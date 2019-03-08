/**
 * Created by max stackhouse under the MIT License, https://github.com/Maxscores/sfdc-rest-controller-framework
 * Description: Used to test the RESTController class and should be used as an example for implementation
 *
 *
 * Test: RESTControllerTest
 */


@RestResource(UrlMapping='/tests')
global class TestRESTController extends RESTController {
    private static TestRESTController controller = new TestRESTController();

    @HttpGet
    global static void getRequest() {
        controller.getRecords();
    }

    @HttpPost
    global static void postRequest() {
        controller.postRecords();
    }

    @HttpPatch
    global static void patchRequest() {
        controller.patchRecords();
    }

    @HttpPut
    global static void putRequest() {
        controller.putRecords();
    }

    @HttpDelete
    global static void deleteRequest() {
        controller.deleteRecords();
    }

    protected override void postRecords() {
        RequestEnvelope requestEnvelope = new RequestEnvelope(request.requestBody.toString());

        String responseString = requestEnvelope.data.firstName + ' ' + requestEnvelope.data.lastName;
        envelope.setData(responseString);

        response.addHeader('Content-Type', 'application/json');
        response.responseBody = envelope.asBlob();
    }
    protected override void patchRecords() {
        envelope.setData('patch records');

        response.addHeader('Content-Type', 'application/json');
        response.responseBody = envelope.asBlob();
    }
    protected override void getRecords() {
        String requestType = request.params.get('Type');
        if (requestType == 'error') {
            envelope.addError('error');
        } else if (requestType == 'message') {
            envelope.addMessage('message');
        }
        envelope.setData('get records');

        response.addHeader('Content-Type', 'application/json');
        response.responseBody = envelope.asBlob();
    }
    protected override void putRecords() {
        envelope.setData('put records');

        response.addHeader('Content-Type', 'application/json');
        response.responseBody = envelope.asBlob();
    }
    protected override void deleteRecords() {
        envelope.setData('delete records');

        response.addHeader('Content-Type', 'application/json');
        response.responseBody = envelope.asBlob();
    }

    public class RequestEnvelope {
        public RequestLead data;

        public RequestEnvelope(String jsonRequest) {
            RequestEnvelope request = (RequestEnvelope) JSON.deserialize(jsonRequest, RequestEnvelope.class);
            data = request.data;
        }
    }

    public class RequestLead {
        public String firstName;
        public String lastName;
    }
}
