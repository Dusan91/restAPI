@RestResource(urlMapping='/assigments/*')

global with sharing class  ManageAssigments  {

	public static List<Assigment__c> results{get;set;}

	@HttpPost
	global static String doPost(String name,String descr,String forC){

		Assigment__c a = new Assigment__c();
		a.Name = name;
		a.Description__c = descr;
		a.For__c = forC;
		insert a;
		return 'Created Assign is  '+ a.Id;
	}

	@HttpGet
	global static List<Assigment__c> doGet() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String assigmentId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		if(assigmentId != ''){
			try{
				results = [SELECT Id, Name, Description__c, For__c FROM Assigment__c WHERE Id = :assigmentId];
			}catch (Exception e){
				System.debug('The following exception has occurred: ' + e.getMessage());
			}
				return results;

		}else{
			results= [SELECT Id, Name, Description__c, For__c FROM Assigment__c];
			return results;
		}
	}

	@HttpPatch
	global static String doPatch(String name,String descr, String forC) {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String assId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Assigment__c ass = [SELECT Id, Name, Description__c, For__c FROM Assigment__c WHERE Id = :assId];
		System.debug(ass);
		if(name != '')
			ass.Name=name;
		if(descr != '')
			ass.Description__c=descr;
		if(forC != '') {
			ass.For__c = forC;
		}
		update ass;
		return 'Assign with Id: '+ass.Id+ ' is updated';
	}


	@HttpDelete
	global static String doDelete() {
		RestRequest req = RestContext.request;
		RestResponse res = RestContext.response;
		String assId = req.requestURI.substring(req.requestURI.lastIndexOf('/')+1);
		Assigment__c ass = [SELECT Id FROM Assigment__c WHERE Id = :assId];
		assId=ass.Id;
		delete ass;
		return 'Assign with '+assId+' id is deleted';
	}

}