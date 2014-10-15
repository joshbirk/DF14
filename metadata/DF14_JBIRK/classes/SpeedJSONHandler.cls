public class SpeedJSONHandler {

    public class SpeedList {
        List<SpeedData> data;
    }
    
    public class SpeedData {
		public String TimeStamp {get; set;}
        public String Pass {get; set;}
        public Decimal Download {get; set;}
        public Decimal Upload {get; set;}
	}
    
    
    static public boolean getData() {
		HttpRequest req = new HttpRequest();

		req.setMethod('GET');
		req.setEndpoint('http://joshbirk-files.herokuapp.com/speed_data.json');
		
		HTTP http = new HTTP();
		HTTPResponse res = http.send(req);
		
		SpeedList slist = (SpeedList)JSON.deserialize(res.getBody(),SpeedList.class);		
        
        List<SpeedTest__c> new_speeds = [SELECT ID from SpeedTest__c];
        delete new_speeds;
        
        for(SpeedData d : slist.data) {
            new_speeds.add(new SpeedTest__c(TimeString__c=d.Timestamp,Upload__c=d.Upload,Download__c=d.Download));
        }
    	insert new_speeds;
    	return true;
    }
	
    
}