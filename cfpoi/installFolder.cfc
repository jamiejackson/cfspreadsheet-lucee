<cfcomponent>

	<cffunction name="install" returntype="struct" output="no" hint="called from Lucee to install application">
		<cfargument name="error" type="struct">
		<cfargument name="path" type="string">
		<cfargument name="config" type="struct">
		
		<cfset var result = {status = true, message = ""} />
		<cfset var serverPath = getContextPath() />
		
		<cftry>
			<cfif !DirectoryExists(serverPath & "/components")>
				<cfdirectory action="create" directory="#serverPath#/components">
			</cfif>
			
			<!--- Export the CFPOI component --->
			<cfzip
				action = "unzip"
				destination = "#serverPath#/components/org"
				file = "#path#cfpoi.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "yes"/>

			<!--- Export the functions --->
			<cfzip
				action = "unzip"
				destination = "#serverPath#/library/function"
				file = "#path#functions.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "false"/>

			<!--- Export the tag --->
			<cfzip
				action = "unzip"
				destination = "#serverPath#/library/tag"
				file = "#path#tags.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "false"/>

			<!--- Export the jars --->
			<cfzip
				action = "unzip"
				destination = "#serverPath#/lib"
				file = "#path#poiLib.zip"
				overwrite = "yes"
				recurse = "yes"
				storePath = "yes"/>
				
				<cfsavecontent variable="temp">
					<cfoutput>
						<p>Tag correctly installed. You will need to Restart Lucee for the functions to work.</p>
					</cfoutput>				
				</cfsavecontent>
				
				<cfset result.message = temp />
			
			<cfcatch type="any">            
				<cfset result.status = false />
				<cfset result.message = cfcatch.message />
				<cflog file="lucee_extension_install" text="Error: #cfcatch.message#">
			</cfcatch>
		
		</cftry>
		
		<cfreturn result />
	
	</cffunction>	
	
	<cffunction name="uninstall" returntype="struct" output="no" hint="called by Lucee to uninstall the application">
		<cfargument name="path" type="any"/>
		<cfargument name="config" type="any"/>
		<cfscript>
			var processResult = {
				status = true,
				message = ""};
			var ssDir = "";
			var serverPath = getContextPath();
			
			processResult.status = deleteAsset("directory", "#serverPath#/components/org/cfpoi");
			processResult.status = deleteAsset("file", "#serverPath#/lib/poi-3.11-20141221.jar");
			processResult.status = deleteAsset("file", "#serverPath#/lib/poi-ooxml-3.11-20141221.jar");
			processResult.status = deleteAsset("file", "#serverPath#/lib/poi-export-utility.jar");
			processResult.status = deleteAsset("file", "#serverPath#/lib/poi-ooxml-schemas-3.11-20141221.jar");
/*
			Files appear to be already loaded by Lucee, this will likely change
			processResult.status = deleteAsset("file", "#serverPath#/lib/dom4j-1.6.1.jar");
			processResult.status = deleteAsset("file", "#serverPath#/lib/geronimo-stax-api_1.0_spec-1.0.jar");
			processResult.status = deleteAsset("file", "#serverPath#/lib/xmlbeans-2.3.0.jar");
*/
			// add xmlbeans-2.6.0.jar as per recommendation of Apache project, though 2.3+ is all that is required
			processResult.status = deleteAsset("file", "#serverPath#/lib/ooxml-lib/xmlbeans-2.6.0.jar");
			processResult.status = deleteAsset("file", "#serverPath#/library/tag/spreadsheet.cfc");
		</cfscript>
		
		<cfdirectory action="list" directory="#serverPath#/library/function" filter="*Spreadsheet*" name="ssDir">
		
		<cfloop query="ssDir">
			<cfset processResult.status = deleteAsset("file", "#ssDir.directory#/#ssDir.name#") />
		</cfloop>
		
		<cfif processResult.status>
			<cfset processResult.message = "Uninstall successful" />
		<cfelse>
			<cfset processResult.message = "Error uninstalling: Please see logs and delete manually" />
		</cfif>
		
		<cfreturn processResult />
	</cffunction>
	
	
	<cffunction name="deleteAsset" returntype="boolean" output="no" hint="called in the uninstall process" access="private">
		<cfargument name="type" required="true" hint="Accepts file|directory" />
		<cfargument name="asset" required="true" hint="location of asset to be removed" />
		
		<cfset var status = true />
		
		<cftry>
			<cfif arguments.type EQ "directory">
				<cfdirectory action="delete" directory="#arguments.asset#" recurse="true" />
			<cfelse>
				<cffile action="delete" file="#arguments.asset#" />
			</cfif>
			<cfcatch type="any">
				<cfset local.errMsg = "Cannot delete #arguments.type# #arguments.asset# | #cfcatch.message#" />
				<cflog file="lucee_extension_poi" text="#local.errMsg#" />
				<cfset status = false/>
			</cfcatch>
		</cftry>
		<cfreturn status />
	</cffunction>
	
	<cffunction name="getContextPath" access="private" returntype="string">
		<cfreturn expandPath('{lucee-#request.adminType#-directory}')>
	</cffunction>
	
 </cfcomponent>