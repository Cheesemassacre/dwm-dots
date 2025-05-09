#!/bin/sh
#Tabwin is script that help you tab any windows with suckless' tabbed
#It work in any desktop environment or windows manager
#This is a fork of BrodieRobertson's tabc.sh (https://gist.github.com/BrodieRobertson/dd7e3d793a501066c50086ed795c0357) 
#Tabwin gitlab : https://gitlab.com/exkc/script/-/blob/master/script/tabwin
#Github gist mirror : https://gist.github.com/exkc/664d5d9e6f72c81813d9fafb5de235b5
#For more infomation about what desktop environment or windows manager are tested : https://gitlab.com/exkc/script/-/blob/master/readme/tabwin.md
#Issue tracker : https://gitlab.com/exkc/script/-/issues
#
#Usage:
#tabwin <command>
#Commands:
#add - Add focused window to tabbed
#remove - Remove focused window from tabbed
#list - List all clients of tabbed
#  
# Functions
#

# Get wid of root window
function get_root_wid {
	xwininfo -root | awk '/Window id:/{print $4}'
}

# Get children of tabbed
function get_clients {
	id=$1
	xwininfo -id $id -children | sed -n '/[0-9]\+ \(child\|children\):/,$s/ \+\(0x[0-9a-z]\+\).*/\1/p'
}

# Get class of a wid
function get_class {
	id=$1
  if [ -z $id ]; then
    echo ""
  else
	  xprop -id $id | sed -n '/WM_CLASS/s/.*, "\(.*\)"/\1/p'
  fi
}
#int main
cmd=$1
naw=$(xprop -root '_NET_ACTIVE_WINDOW' |awk -F ':' '{print $2}')
if ! echo $naw |grep 'no' > /dev/zero
then
fwid=$(echo $naw|sed 's/window id #//g;s/ //g')
elif ! [ "$(xdotool getmouselocation --shell | grep WINDOW|sed 's/WINDOW=//g')" == 0 ]
then
fwid=$(xdotool getmouselocation --shell | grep WINDOW|sed 's/WINDOW=//g')
else
tmp=$(mktemp)
xdotool click 1|xwininfo > $tmp
fwid=$(awk '/Window id/ {print}' $tmp |awk -F ':' '{print $3}'|awk '{print $1}'|sed 's/ //g')
rm $tmp
fi
if [ "$(xprop -root)" == "$(xprop -id $fwid)" ] && [ ! $cmd == list ] ; then exit 9;fi
if xprop -id $fwid |grep 'WM_CLASS'|grep 'tabbed' > /dev/zero
		then
		tabbedid=$fwid
		else
		tabbedid=$(xdotool search --class tabbed | tail -n1)
		fi
		if [ ! -z $cmd ]
		then
		if [  $cmd == add ] && [ -z $tabbedid ]; then
		tabbedid=$(tabbed -c -d)
		fi
		fi
case $cmd in
	add)
		if ! [  $fwid == $tabbedid ]
		then
			xdotool windowreparent $fwid $tabbedid
	else
		exit
		fi
		;;
	remove)
		if [ -z $tabbedid ];then exit;fi
		if xprop -id $fwid |grep 'WM_CLASS'|grep 'tabbed' > /dev/zero
		then
		if  xprop -id $tabbedid _TABID | grep no > /dev/zero 
		then
		tatitle=$(xprop -id $tabbedid| awk "/WM_NAME/ {print}"|awk "(NR>= 1 && NR <=1){print}"|awk -F ' = ' '{print $2}'|sed 's/"//g') 
		wid=$(xwininfo -id $tabbedid -children | awk "/${tatitle}/ {print}" |awk '{print $1}' | shuf |sed '1q')
		cat << IDK
Waring!your bulid of tabbed didn't have this patch installed (link to download this patch:https://gitlab.com/exkc/tabbed-exkc/-/raw/master/patches/tabwin.patch)
you have to patch your tabbed with this patch otherwise
Tabwin might not remove focused tab when multiple tab have same title
For learn about this issue:https://gitlab.com/exkc/script/-/issues/2

IDK
	else
		wid=$(xprop -id $tabbedid  _TABID | awk -F ' = ' '{print $2}' |sed 's/"//g')
	fi
		xdotool windowreparent $wid  $(get_root_wid)
		fi
	if [ "$(xwininfo -children -id $tabbedid |awk '/child/{print}'|awk '{print $1}')" == 0 ]
	then
		xdotool  windowkill $tabbedid
		fi
		;;
	list)
		get_clients $tabbedid
		;;
	*) 
	cat << BTW_I_USE_ARTIX
Tabwin is script that help you tab any windows with suckless' tabbed
It work in any desktop environment or windows manager
This is a fork of BrodieRobertson's tabc.sh (https://gist.github.com/BrodieRobertson/dd7e3d793a501066c50086ed795c0357) 
Tabwin gitlab : https://gitlab.com/exkc/script/-/blob/master/script/tabwin
Github gist mirror : https://gist.github.com/exkc/664d5d9e6f72c81813d9fafb5de235b5
For more infomation about what desktop environment or windows manager are tested : https://gitlab.com/exkc/script/-/blob/master/readme/tabwin.md
Issue tracker : https://gitlab.com/exkc/script/-/issues

Usage:
tabwin <command>
Commands:
   add - Add focused window to tabbed
   remove - Remove focused window from tabbed
   list - List all clients of tabbed

BTW_I_USE_ARTIX
exit 
esac