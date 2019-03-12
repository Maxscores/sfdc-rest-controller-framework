/**
 * Created by max stackhouse under the MIT License, https://github.com/Maxscores/sfdc-rest-controller-framework
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
    @TestVisible
    protected StatusCode statusCode = new StatusCode();
    protected RESTResponseEnvelope envelope = new RESTResponseEnvelope();

    // implementation methods
    @TestVisible
    protected virtual void postRecords() {}
    @TestVisible
    protected virtual void patchRecords() {}
    @TestVisible
    protected virtual void getRecords() {}
    @TestVisible
    protected virtual void putRecords() {}
    @TestVisible
    protected virtual void deleteRecords() {}

    public class StatusCode {
        // HTTP Status codes from https://www.restapitutorial.com/httpstatuscodes.html
        // 2xx = Successful Responses
        public Integer ok = 200;
        public Integer created = 201;
        public Integer noContent = 204;
        // 3xx = Redirection
        public Integer movedPermanently = 301;
        public Integer notModified = 304; // from wikipedia: Indicates that the resource has not been modified since the version specified by the request headers If-Modified-Since or If-None-Match. In such case, there is no need to retransmit the resource since the client still has a previously-downloaded copy.
        // 4xx = Client Error (problem with request)
        public Integer badRequest = 400;
        public Integer unauthorized = 401;
        public Integer forbidden = 403;
        public Integer notFound = 404;
        // 5xx = Server Error (problem with server), should automatically get returned if there is an error
        public Integer internalServerError = 500;
    }
}
