void
view(const Arg *arg)
{
    int i;
    unsigned int tmptag;
    unsigned int requested_tagmask = arg->ui & TAGMASK;

    if (requested_tagmask != 0 && requested_tagmask != selmon->tagset[selmon->seltags]) {
        // Switching to a new tag
        selmon->seltags ^= 1;
        selmon->tagset[selmon->seltags] = requested_tagmask;
        selmon->pertag->prevtag = selmon->pertag->curtag;
        if (requested_tagmask == ~0)
            selmon->pertag->curtag = 0;
        else {
            for (i = 0; !(requested_tagmask & (1 << i)); i++) ;
            selmon->pertag->curtag = i + 1;
        }
    } else {
        // Toggle to previous tagset (either same tag requested or arg->ui == 0)
        selmon->seltags ^= 1;
        tmptag = selmon->pertag->prevtag;
        selmon->pertag->prevtag = selmon->pertag->curtag;
        selmon->pertag->curtag = tmptag;
    }

    // Update pertag settings
    selmon->nmaster = selmon->pertag->nmasters[selmon->pertag->curtag];
    selmon->mfact = selmon->pertag->mfacts[selmon->pertag->curtag];
    selmon->sellt = selmon->pertag->sellts[selmon->pertag->curtag];
    selmon->lt[selmon->sellt] = selmon->pertag->ltidxs[selmon->pertag->curtag][selmon->sellt];
    selmon->lt[selmon->sellt^1] = selmon->pertag->ltidxs[selmon->pertag->curtag][selmon->sellt^1];

    if (selmon->showbar != selmon->pertag->showbars[selmon->pertag->curtag])
        togglebar(NULL);

    focus(NULL);
    arrange(selmon);
}
