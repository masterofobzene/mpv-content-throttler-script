# Content-throttler
An mpv player script to fix inbalance in playback of content.

__TL;DR__: It evens the playlist when you have big folders with so much 
content that it floods all the playlist with its media. This script will
 give a fair share to other media for playback automatically without modifying the playlist.


## WHA?!

Ok I won't lie to you. This is a VERY niche script, for a VERY specific scenario. Still, its a good solution to a problem that I did not know how to address without editing playlists manually 👎 or removing files 😭.

_lets say_ you have a 'MEDIA' folder and inside that folder you have many subfolders, each with its own theme and filled of differently themed media, say pictures, say videos, or both. 

Now _lets say_ that out of __20 subfolders__ of different themes, __5 are MASSIVE__ and have MUCH MORE media than the other 15 regular ones. You play the MEDIA folder and you get 90% the content of the 5 biggest sized subfolders, because there is too much of that content that it occludes all the rest, the 15 other folders containing other themed media are rarely played.

This script comes to alleviate this by: checking where the currently played file is from ``{folder name}`` then adding it to a temporal blacklist of __configurable time__ in which mpv will skip ahead all iterations of files from ``{folder name}`` then after the time is reached _(60 seconds by default)_ it resumes playing a file from ``{folder name}`` and puts a new timer, and so on with all folders. The loop completes if you have enough non 'penalized' folders for playback and gives you a healthy 1 file per folder playback to ensure you don't get files from one massive folder all the time and give opportunity to other folders to be played. When you play a folder or a folder with small number of subfolders you will hit the _no more files without 'penalization' loop break_, because you can't play any more files because all are still with the timer!, in this case the script is smart enough to let the player play the files like if the script is not working at all, and then when a folder timer is up, it will re engage its operation.
So you can even play one folder and the script will not break. Are you still there? no centennial has come this far.


## I've skipped the wall of text. How to use?

The script works on its own. You must place it on the ``scripts`` folder in your MPV installation folder.
BUT there is a strict rule for it to work: 

The folder structure you play must be something like this: ``Z:\FOLDER\SUBFOLDER 1\OPTIONAL\OPTIONAL\{files}`` in which in this example, you are playing ``FOLDER``.
This is because the script will select the first SUBfolder as the "root" for applying the penalization. In this example, the penalization (60 seconds) will be applied to ``SUBFOLDER 1`` and all its subfolders.
``` 
Z:/
└── FOLDER/
    ├── SUBFOLDER 1/
    │   └── OPTIONAL/
    │       └── OPTIONAL/
    │           └── {files}
    ├── SUBFOLDER 2/
    │   └── ... (same structure as SUBFOLDER 1)
    ├── SUBFOLDER 3/
    │   └── ...
    └── SUBFOLDER 4/
        └── ...
```

So the rule is that you store your media in a similar way. 

# Download
<a href="https://raw.githubusercontent.com/masterofobzene/mpv-content-throttler-script/refs/heads/main/content-throttler.lua">RIGHT CLICK -> Save Link As</a>

Sorry for the long text but there is no other way of explaning this specific script.
