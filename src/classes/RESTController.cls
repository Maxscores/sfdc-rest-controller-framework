/**
 * Created by mstackhouse on 2/25/2019.
 * Description: Virtual class for a REST Controller to provide inherited methods for standardization.
 *
 * Usage: When defining a specific REST controller for a resource extend this class and overwrite methods
 *  `global without sharing class AccountsRESTController extends RESTController {`
 * For an example class, reference RESTControllerTest.TestRESTController
 *
 * Note** Make sure to name your classes and endpoints plurally. Ex: Accounts instead of Account
 *
 * Test: RESTControllerTest
 *
 */

//@RestResource(urlMapping='/v1/')
global virtual class RESTController {
    protected RestResponse response = RestContext.response;
    protected RestRequest request = RestContext.request;

    protected virtual RestResponse postRecords() {
        // implementation logic
        return new RestResponse();
    }
    protected virtual RestResponse patchRecords() {
        // implementation logic
        return new RestResponse();
    }
    protected virtual RestResponse getRecords() {
        // implementation logic
        return new RestResponse();
   }
    protected virtual RestResponse putRecords() {
        // implementation logic
        return new RestResponse();
    }
    protected virtual RestResponse deleteRecords() {
        // implementation logic
        return new RestResponse();
    }

    global class ResponseEnvelope {
        global List<String> messages = new List<String>();
        global List<String> errors = new List<String>();
        global Object data;

        public ResponseEnvelope(Object singleObject) {
            data = singleObject;
        }

        public ResponseEnvelope(List<Object> objectList) {
            data = objectList;
        }

        public Blob getBlob() {
            return Blob.valueOf(JSON.serialize(this));
        }
    }

    // HTTP Status codes from https://www.restapitutorial.com/httpstatuscodes.html
    // 2xx = Successful Responses
    @TestVisible
    protected Integer ok = 200;
    @TestVisible
    protected Integer created = 201;
    @TestVisible
    protected Integer noContent = 204;
    // 3xx = Redirection
    @TestVisible
    protected Integer movedPermanently = 301;
    @TestVisible
    protected Integer notModified = 304; // from wikipedia: Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. In such case, there is no need to retransmit the resource since the client still has a previously-downloaded copy.
    // 4xx = Client Error (problem with request)
    @TestVisible
    protected Integer badRequest = 400;
    @TestVisible
    protected Integer unauthorized = 401;
    @TestVisible
    protected Integer forbidden = 403;
    @TestVisible
    protected Integer notFound = 404;
    // 5xx = Server Error (problem with server), should automatically get returned if there is an error
    @TestVisible
    protected Integer internalServerError = 500;
}
