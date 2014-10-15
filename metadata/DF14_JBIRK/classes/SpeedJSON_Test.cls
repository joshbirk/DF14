@isTest
global class SpeedJSON_Test {

    global class SpeedJSON_HTTP implements HttpCalloutMock {
        global HTTPResponse respond(HTTPRequest req) {
           // Create a fake response
            HttpResponse res = new HttpResponse();
            res.setHeader('Content-Type', 'application/json');
            res.setBody('{"data": [{"Timestamp": "20140220 22:20:33","Pass": false,"Download": 1.09,"Upload": 0.64}]}');
            res.setStatusCode(200);
            return res;
        }
    }	
    
    @isTest
    public static void testJSONHandler() {
        SpeedJSONHandler spj = new SpeedJSONHandler();
        SpeedJSONHandler.SpeedData spd = new SpeedJSONHandler.SpeedData();
        SpeedJSONHandler.SpeedList spl = new SpeedJSONHandler.SpeedList();
        
        Test.setMock(HttpCalloutMock.class, new SpeedJSON_HTTP());
        
        System.assertEquals(true,SpeedJSONHandler.getData());
    }
    
}