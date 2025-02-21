void
fibonacci(Monitor *mon, int s) {
	unsigned int i, n, nx, ny, nw, nh;
	Client *c;
	int gap = 10; // Define the gap size

	for(n = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next), n++);
	if(n == 0)
		return;
	
	// Adjust the initial position and size to account for the outer gaps
	nx = mon->wx + gap;
	ny = mon->wy + gap;
	nw = mon->ww - 2 * gap;
	nh = mon->wh - 2 * gap;
	
	for(i = 0, c = nexttiled(mon->clients); c; c = nexttiled(c->next)) {
		if((i % 2 && nh / 2 > 2 * c->bw)
		   || (!(i % 2) && nw / 2 > 2 * c->bw)) {
			if(i < n - 1) {
				if(i % 2)
					nh = (nh - gap) / 2;
				else
					nw = (nw - gap) / 2;
				if((i % 4) == 2 && !s)
					nx += nw + gap;
				else if((i % 4) == 3 && !s)
					ny += nh + gap;
			}
			if((i % 4) == 0) {
				if(s)
					ny += nh + gap;
				else
					ny -= nh + gap;
			}
			else if((i % 4) == 1)
				nx += nw + gap;
			else if((i % 4) == 2)
				ny += nh + gap;
			else if((i % 4) == 3) {
				if(s)
					nx += nw + gap;
				else
					nx -= nw + gap;
			}
			if(i == 0)
			{
				if(n != 1)
					nw = (mon->ww - 2 * gap) * mon->mfact;
				ny = mon->wy + gap;
			}
			else if(i == 1)
				nw = mon->ww - nw - 3 * gap; // Adjust for right-side gap
			i++;
		}
		// Adjust the window size to account for the gaps
		resize(c, nx, ny, nw - 2 * c->bw, nh - 2 * c->bw, False);
	}
}

void
dwindle(Monitor *mon) {
	fibonacci(mon, 1);
}

void
spiral(Monitor *mon) {
	fibonacci(mon, 0);
}
