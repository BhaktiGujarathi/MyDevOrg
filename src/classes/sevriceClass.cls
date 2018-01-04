public with sharing class sevriceClass {
 public httpResponse callToGoogle()
    {
        HttpRequest req = new HttpRequest();
        string query = 'what is salesforce?';
        req.setEndpoint('https://www.google.com/'+'#q='+query);
        req.setMethod('GET');
        req.setHeader('Charset', 'UTF-8');
        //req.setHeader('Content-Length', '512');
        req.setHeader('Content-Type', 'application/json');
       // req.setTimeout(2  60  1000);
        Http http = new Http(); 
        HttpResponse res = http.send(req);
        system.debug('*******rsponse '+res);
        string responseBody = res.getbody();
        Xmlstreamreader reader = new Xmlstreamreader(responseBody);
        system.debug('>>>>>>>READER>>>>>'+reader);
        while(reader.hasNext()) { 
        //  Start at the beginning of the book and make sure that it is a book   
         if (reader.getEventType() == XmlTag.START_ELEMENT) {
            if ('a href' == reader.getLocalName()) {              
                system.debug('>>>>>####did it>>>>>');
            }
         }
        reader.next();
       }
        
        return res;
    }
    
    
}