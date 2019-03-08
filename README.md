# sfdc-rest-controller-framework
Generic framework that can be used to implement REST Controllers. Contributions are welcome! Would love to extend the class to include more generic functionality.

## Overview

REST has become the standard for modern web APIs. This framework provides a standardized approach to building REST Endpoints and provides access to important status codes and a standardized response envelope that follows a popular schema. The framework assumes you'll be using JSON for the requests and responses since it is so simple to work with.

**Deploy to Salesforce Org:**
[![Deploy](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com/?owner=Maxscores&repo=sfdc-rest-controller-framework&ref=master)

The default response schema follows industry guidelines:
```json
{
    "data": {},
    "messages": [],
    "errors": []
}
```

## Usage

To create a REST Controller for a specific resource, you'll need to create a class that inherits from **RESTController.cls** and uses the @RestResource annotaion. Below is an example of the basic class setup.
```java
@RestResource(UrlMapping='/accounts')
global class AccountsRESTController extends RESTController {
    private static AccountsRESTController controller = new AccountsRESTController();
```
Additionally, you'll need to implement overrides and call them on the standard restful routes. Here's an example of the GET route:
```java
@RestResource(UrlMapping='/accounts')
global class AccountsRESTController extends RESTController {
    private static AccountsRESTController controller = new AccountsRESTController();

    @HttpGet
    global static void getAccounts() {
        controller.getRecords();
    }

    public override void getRecords() {
        // will need to implement the override method to return the response, something like:
        Account accountToReturn = [Select Id From Account];
        envelope.addData(accountToReturn);
        response.responseBody = envelope.asBlob();
        response.addHeader('Content-Type','application/json');
    }
}
```
When writing tests, you'll need to write an implementation of the resulting envelope class in that test method in order to parse the results from a JSON Blob into Apex. For the above example it would look something like this:
```java
@IsTest
public with sharing class AccountsRESTControllerTest {
    public static AccountResponseEnvelope getAccountResponseEnvelope(RestResponse respose) {
        String jsonResponse = response.responseBody.toString();
        return (AccountResponseEnvelope) JSON.deserialize(jsonResponse, AccountResponseEnvelope.class);
    }

    public class AccountResponseEnvelope {
        public List<String> messages;
        public List<String> errors;
        public Account data;
    }

    public static AccountsResponseEnvelope getAccountsResponseEnvelope(RestResponse respose) {
        String jsonResponse = response.responseBody.toString();
        return (AccountsResponseEnvelope) JSON.deserialize(jsonResponse, AccountsResponseEnvelope.class);
    }

    public class AccountsResponseEnvelope {
        public List<String> messages;
        public List<String> errors;
        public List<Account> data;
    }   
}
```

Using the above methods, your test methods will look something like this:
```java
@IsTest
public with sharing class AccountsRESTControllerTest {
    @IsTest
    public static void testGet() {
        Account account = new Account();
        insert account;

        RestRequest req = new RestRequest();
        req.requestURI = '/services/apexrest/accounts/' + account.Id;
        req.httpMethod = 'GET';
        req.addHeader('Content-Type', 'application/json');

        RestContext.request = req;
        RestContext.response = new RestResponse();
        AccountsRESTController.getRequest();

        RestResponse response = RestContext.response;

        AccountResponseEnvelope envelope = getAccountResponseEnvelope(response);
        System.assert(envelope.errors.isEmpty(), 'there should be no errors');
        System.assert(envelope.messages.isEmpty(), 'there should be no messages');
        System.assertEquals(account, envelope.data);
    }
}
```

The framework also provides a suggestion for formatting incoming data. For this, you'll need to implement two pieces.
1) a request data prototype (RequestLead)
2) a request envelope (RequestEnvelope) that uses the request data prototype and has a constructor

This will allow you to deserialize the data from JSON. See the example from the TestRESTController:
```java
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
```
