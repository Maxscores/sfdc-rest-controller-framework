/**
 * Created by mstackhouse on 2/25/2019.
 * Description: Used to test the RESTController class and should be used as an example for implementation
 * Test: RESTControllerTest
 */


@RestResource(UrlMapping='/tests')
global class TestRESTController extends RESTController {
    private static TestRESTController controller = new TestRESTController();

    @HttpGet
    global static void getRequest() {
        RestContext.response = controller.getRecords();
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

    public override RestResponse postRecords() {
        response.addHeader('Content-Type', 'application/json');
        response.responseBody = new ResponseEnvelope('post records').getBlob();
        return response;
    }
    public override RestResponse patchRecords() {
        response.addHeader('Content-Type', 'application/json');
        response.responseBody = new ResponseEnvelope('patch records').getBlob();
        return response;
    }
    public override RestResponse getRecords() {
        response.addHeader('Content-Type', 'application/json');
        response.responseBody = new ResponseEnvelope('get records').getBlob();
        return response;
    }
    public override RestResponse putRecords() {
        response.addHeader('Content-Type', 'application/json');
        response.responseBody = new ResponseEnvelope('put records').getBlob();
        return response;
    }
    public override RestResponse deleteRecords() {
        response.addHeader('Content-Type', 'application/json');
        response.responseBody = new ResponseEnvelope('delete records').getBlob();
        return response;
    }
}
