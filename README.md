&lt;cfspreadsheet&gt; for Lucee

This is a fork of the Team CFAdvance cfspreadsheet-railo extension, modified to work with the Lucee fork of Railo. Please refer to that site for more details. I've bumped the version from v341 to v350 to denote this change.

### Installation: via Lucee Admin GUI

In this method, you will create your own temporary extension provider:

1. Download cfspreadsheet-lucee.zip
1. Extract into `/path/to/your/wwwroot/luceeExtensionProvider` (you should then have 2 files in that folder: cfpoi.zip and ExtensionProvider.cfc)
1. Add a file `/path/to/your/wwwroot/luceeExtensionProvider/Application.cfc` with the contents<br>`component {}`
1. Lucee *Web* Admin > Extensions > Providers: Add:  http://&lt;your_local_site_host&gt;/luceeExtensionProvider/ExtensionProvider.cfc (ensure you are using the correct port in your setup)
1. Lucee *Web* Admin > Extensions > Applications:  Click on "&lt;cfspreadhsheet/&gt; tag &amp;a... Free" (sic)
1. Click "Install" Button
1. Restart Lucee or Tomcat (depending on installation type)