component displayname="extension provider" output="false" {
	
	instance = {
		thisAddress = "http://#cgi.SERVER_NAME#:#cgi.SERVER_PORT#/luceeExtensionProvider/"
	};
	
	
	remote struct function getInfo(){
		var info = {
			title="cfspreadsheet-lucee",
			description="A spreadsheet extension for Lucee",
			image="#instance.thisAddress#/img/leftbower.png",
			url="https://github.com/Leftbower/cfspreadsheet-lucee",
			mode="develop"
		};
		return info;
	}
	
	remote query function listApplications(){
		var apps = queryNew('type,id,name,label,description,version,category,image,download,author,codename,video,support,documentation,forum,mailinglist,network,created');
		var rootURL=getInfo().url;
		var desc = "cfspreadsheet";
		QueryAddRow(apps);
		QuerySetCell(apps,'id','10EEC23A-0779-4068-9507A9C5ED4A8641');
		QuerySetCell(apps,'name','cfspreadsheet');
		QuerySetCell(apps,'type','all');
		QuerySetCell(apps,'label','&lt;cfspreadsheet /&gt;');
		QuerySetCell(apps,'description',desc);
		QuerySetCell(apps,'author','Ext by Andrew Kretzer.<br/>CFPOI by Matt Woodward');
		QuerySetCell(apps,'image','#instance.thisAddress#/img/Apps-Spreadsheet-App-icon.png');
		QuerySetCell(apps,'support','https://github.com/Leftbower/cfspreadsheet-lucee/issues');
		QuerySetCell(apps,'documentation','https://github.com/Leftbower/cfspreadsheet-lucee/wiki');
		QuerySetCell(apps,'created',CreateDate(2015,2,27));
		QuerySetCell(apps,'version',"3.51");
		QuerySetCell(apps,'category',"Application");
		QuerySetCell(apps,'download','#instance.thisAddress#/cfpoi.zip');
		//QuerySetCell(apps,'download','https://github.com/Leftbower/cfspreadsheet-lucee/raw/master/cfpoi.zip');
		
		return apps;			
	}
}

