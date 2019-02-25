/**
 * Created by mstackhouse on 2/25/2019.
 * Description: Tests RESTController using the TestRESTController implementation
 */

@IsTest
public with sharing class RESTControllerTest {
    @IsTest
    public static void testGet() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.getRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('get records', envelope.data);
    }

    @IsTest
    public static void testPut() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'PUT';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.putRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('put records', envelope.data);
    }

    @IsTest
    public static void testPost() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'POST';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.postRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('post records', envelope.data);
    }

    @IsTest
    public static void testPatch() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'PATCH';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.patchRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('patch records', envelope.data);
    }

    @IsTest
    public static void testDelete() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'DELETE';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.deleteRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('delete records', envelope.data);
    }

    @IsTest
    public static void testStatuses() {
        TestRESTController controller = new TestRESTController();

        System.assertEquals(200, controller.ok);
        System.assertEquals(201, controller.created);
        System.assertEquals(204, controller.noContent);
        System.assertEquals(301, controller.movedPermanently);
        System.assertEquals(304, controller.notModified);
        System.assertEquals(400, controller.badRequest);
        System.assertEquals(401, controller.unauthorized);
        System.assertEquals(403, controller.forbidden);
        System.assertEquals(404, controller.notFound);
        System.assertEquals(500, controller.internalServerError);
    }

    public static TestResponseEnvelope getResponseEnvelope(RestResponse response) {
        String jsonResponse = response.responseBody.toString();
        return (TestResponseEnvelope) JSON.deserialize(jsonResponse, TestResponseEnvelope.class);
    }

    public class TestResponseEnvelope {
        public List<String> messages;
        public List<String> errors;
        public String data;
    }
}
