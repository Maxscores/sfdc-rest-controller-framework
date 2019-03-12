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
 * Test: RESTResponseEnvelopeTest
 *
 */

global virtual class RESTResponseEnvelope {
    @TestVisible
    protected List<String> messages = new List<String>();
    @TestVisible
    protected List<String> errors = new List<String>();
    @TestVisible
    protected Object data;

    public void setData(Object dataObject) {
        data = dataObject;
    }

    public void addErrors(List<String> errorsToAdd) {
        errors.addAll(errorsToAdd);
    }

    public void addError(String errorToAdd) {
        errors.add(errorToAdd);
    }

    public void addMessages(List<String> messagesToAdd) {
        messages.addAll(messagesToAdd);
    }

    public void addMessage(String messageToAdd) {
        messages.add(messageToAdd);
    }

    public void setJSONResponse(RestResponse response) {
        response.responseBody = Blob.valueOf(JSON.serialize(this));
        response.addHeader('Content-Type', 'applicaiton/json');
    }
}