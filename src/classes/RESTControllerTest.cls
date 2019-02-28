/**
 * Created by max stackhouse under the MIT License, https://github.com/Maxscores/sfdc-rest-controller-framework
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
    public static void testErrors() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('Type', 'error');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.getRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assertEquals(1, envelope.errors.size(), 'there should be one error');
        System.assertEquals('error', envelope.errors[0]);
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals('get records', envelope.data);
    }

    @IsTest
    public static void testMessages() {
        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/tests/12345';
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');
        req.addParameter('Type', 'message');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        TestRESTController.getRequest();

        RestResponse response = RestContext.response;

        TestResponseEnvelope envelope = getResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assertEquals(1, envelope.messages.size(), 'there should be one message');
        System.assertEquals('message', envelope.messages[0]);
        System.assertEquals('get records', envelope.data);
    }

    @IsTest
    public static void testStatuses() {
        TestRESTController controller = new TestRESTController();

        System.assertEquals(200, controller.statusCode.ok);
        System.assertEquals(201, controller.statusCode.created);
        System.assertEquals(204, controller.statusCode.noContent);
        System.assertEquals(301, controller.statusCode.movedPermanently);
        System.assertEquals(304, controller.statusCode.notModified);
        System.assertEquals(400, controller.statusCode.badRequest);
        System.assertEquals(401, controller.statusCode.unauthorized);
        System.assertEquals(403, controller.statusCode.forbidden);
        System.assertEquals(404, controller.statusCode.notFound);
        System.assertEquals(500, controller.statusCode.internalServerError);
    }

    @IsTest
    public static void testResponseEnvelope() {
        RESTController.ResponseEnvelope envelope = new RESTController.ResponseEnvelope();

        System.assertNotEquals(null, envelope.errors);
        System.assertNotEquals(null, envelope.messages);
        System.assertEquals(null, envelope.data);

        envelope.setData('hello');
        System.assertEquals('hello', envelope.data);

        envelope.setData(List<String>{'hello', 'my', 'friend'});
        System.assertEquals(3, envelope.data.length);

        envelope.addError('error 1');
        System.assertEquals('error 1', envelope.errors[0]);

        envelope.addErrors(new List<String>{'error 2', 'error 3'});
        System.assertEquals('error 2', envelope.errors[1]);
        System.assertEquals('error 3', envelope.errors[2]);

        envelope.addMessage('Message 1');
        System.assertEquals('Message 1', envelope.message[0]);

        envelope.addMessages(new List<String>{'Message 2', 'Message 3'});
        System.assertEquals('Message 2', envelope.messages[1]);
        System.assertEquals('Message 3', envelope.messages[2]);

        System.assertEquals(Blob.type, envelope.data.asBlob().type);
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
