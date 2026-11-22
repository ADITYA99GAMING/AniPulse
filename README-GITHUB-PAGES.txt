AniPulse — GitHub Pages deployment
==================================

This is a static HTML project. It does not require npm, Node.js, or a build step.

PUBLISH
1. Create a GitHub repository (for example: AniPulse).
2. Upload the CONTENTS of this folder to the repository root (not the enclosing folder).
3. Confirm the homepage file is named exactly: index.html
4. Open Settings > Pages.
5. Under Build and deployment, choose "Deploy from a branch".
6. Select branch "main" and folder "/ (root)", then Save.
7. Wait for the Pages deployment to finish. The URL will be:
   https://YOUR-USERNAME.github.io/AniPulse/

NOTES
- .nojekyll is included so GitHub Pages serves the static files without Jekyll processing.
- The site loads Tailwind CSS, fonts, and icons from third-party CDNs, so those features need an internet connection.
- Browser localStorage is used for locally saved data. It is per-browser/device and is not a shared database.
- A static GitHub Pages site cannot securely provide shared accounts, server-side admin permissions, or synchronized admin changes. Those features need a backend service.
- The season URLs currently stored in the sample catalogue are external placeholder URLs (AniList, MyAnimeList, and Kitsu). The anime detail HTML files included in this project are not automatically connected to those catalogue entries. Add the correct relative page URLs in the admin season URL fields after deployment, or wire the entries to the matching local pages in the code.
- Video playback depends on the external video/embedding URLs entered in the pages and on the providers allowing embedding.
