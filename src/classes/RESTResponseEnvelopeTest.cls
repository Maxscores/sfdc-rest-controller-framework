/**
 * Created by max stackhouse under the MIT License, https://github.com/Maxscores/sfdc-rest-controller-framework
 * Description: Virtual class for a REST Controller to provide inherited methods for standardization.
 *
 * Usage: When defining a specific REST controller for a resource extend this class and overwrite methods
 *  `global without sharing class AccountsRESTController extends RESTController {`
 * For an example class, reference RESTControllerTest.TestRESTController
 *
 *
 *
 */

@isTest
private class RESTResponseEnvelopeTest {

    @isTest
    static void myUnitTest() {
        // TO DO: implement unit test
    }
    @IsTest
    public static void testAddError() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();
        
        envelope.addError('error 1');
        System.assertEquals('error 1', envelope.errors[0]);
    }
    
    @IsTest
    public static void testAddErrors() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();
        
        envelope.addErrors(new List<String>{'error 2', 'error 3'});
        System.assertEquals('error 2', envelope.errors[0]);
        System.assertEquals('error 3', envelope.errors[1]);
    }
    
    @IsTest
    public static void testAddEMessage() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();
        
        envelope.addMessage('Message 1');
        System.assertEquals('Message 1', envelope.messages[0]);
    }
    
    @IsTest
    public static void testAddMessages() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();
        
        envelope.addMessages(new List<String>{'Message 2', 'Message 3'});
        System.assertEquals('Message 2', envelope.messages[0]);
        System.assertEquals('Message 3', envelope.messages[1]);
    }

    @IsTest
    public static void testResponseEnvelopeCreation() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();

        System.assertNotEquals(null, envelope.errors);
        System.assertNotEquals(null, envelope.messages);
        System.assertEquals(null, envelope.data);
    }

    @IsTest
    public static void testSetData() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();

        envelope.setData('hello');
        System.assertEquals('hello', envelope.data);

        envelope = new RESTResponseEnvelope();
        envelope.setData(new List<String>{'hello', 'my', 'friend'});
        System.assertEquals(new List<String>{'hello', 'my', 'friend'}, envelope.data);
    }

    @IsTest
    public static void testSetJSONResponse() {
        RESTResponseEnvelope envelope = new RESTResponseEnvelope();
        envelope.setData(new List<String>{'hello', 'my', 'friend'});

        RestResponse response = new RestResponse();

        System.assertNotEquals('application/json', response.headers.get('Content-Type'));
    }
}