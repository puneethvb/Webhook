global with sharing class SOAPWebServiceClass {
    global SOAPWebServiceClass() {

    }

    global class Request{

        webservice String name;
        webservice Integer num;

    }

    global class Response{
      webservice String resultMap;
      webservice String randomText;
    }

    webservice static Response mySOAPMethod(List<Request> incomingRequestList){

        Response response = new Response();
        response.resultmap = '123';
        response.randomText = String.valueOf(Math.random());
        //response.resultMap.put(incomingRequest.name,incomingRequest.number);
        return response;
    }
}