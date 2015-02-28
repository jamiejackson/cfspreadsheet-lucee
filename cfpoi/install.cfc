component extends="InstallFolder" {
	
	void function validate(Struct error, String path, Struct config, Numeric step){
		
	}

	string function install(Struct error, String path, Struct config){
		var sReturn = "";
		var stReturn = super.install(argumentCollection:arguments);
		
		if(stReturn.status){
			sReturn = stReturn.message;
		}
		else{
			savecontent variable="sReturn"{
				uninstall(argumentCollection=arguments);
				echo('<p style="color:red">Tags has not been installed.</p>' & stReturn.message);
			} 
		}
		
		return sReturn;
	}

	string function uninstall(String path, Struct config){
		var sReturn = "";
		var stReturn = super.uninstall(argumentCollection:arguments);
		
		if(stReturn.status){
			if( len(trim(stReturn.message)) ){
				sReturn = stReturn.message;
			}
			else{
				savecontent variable="sReturn"{
					uninstall(argumentCollection=arguments);
					echo('<p>Tag has been successfully removed!</p>');
				}
			}
		}
		else{
			savecontent variable="sReturn"{
				uninstall(argumentCollection=arguments);
				echo('<p style="color:red">Some error occurred during the uninstall process:</p>' & stReturn.message);
			} 
		}
		
		return sReturn;
	}

	string function update(){
		return install(argumentCollection=arguments);
	}
	
}