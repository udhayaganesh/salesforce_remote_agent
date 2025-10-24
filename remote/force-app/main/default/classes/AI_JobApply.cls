public class AI_JobApply {
    public class RequestDetails {
        @InvocableVariable(required=true label='Employee Description' )
        public String description;
        @InvocableVariable(required=true label='JobPostingName' )
        public String JobPostingName;
    }
    
    public class Response {
        @InvocableVariable(label='isSuccess')
        public Boolean isSuccess;
        @InvocableVariable(label='message')
        public String message;
    }
    
    @InvocableMethod(label='Apply for a Job' description='Apply for a Job based on the user input')
    public static List<Response> JobApplyAction(List<RequestDetails> inputs) {
        //Fetch the user input
        List<Response> outputs = new List<Response>();
        Response  response= new Response();
        response.isSuccess = false;    
        String JobPostingName, description;
        for ( RequestDetails input : inputs) {
            description = input.description;
            JobPostingName=input.JobPostingName;
        }
        system.debug(JobPostingName+'######## input #######' +description);
        
        try{
            JobPosting__c jp = [select id, name from JobPosting__c where name =:JobPostingName];
            if(description!=null)
            {
                JobApplication__c ja= new JobApplication__c(Contact_Details__c =description,JobPosting__c  =jp.id);
                insert ja;
            }
            
            response.isSuccess = false;
            
            response.message = ' Job applied Succesfully '  ;
            
            
            
        }
        catch(Exception e)
        {
            system.debug('###############'+e);
            response.message = 'Job not applied, contact HR for more details' ;
        }
        
        outputs.add(response);
        return outputs;
    }
}