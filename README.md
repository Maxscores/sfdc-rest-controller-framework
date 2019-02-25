# sfdc-rest-controller-framework
Generic framework that can be used to implement REST Controllers

## Overview

REST has become the standard for modern web APIs. This framework provides a standardized approach to building REST Endpoints and provides access to important status codes and a standardized response envelope that follows a popular schema.

**Deploy to Salesforce Org:**
[![Deploy](https://raw.githubusercontent.com/afawcett/githubsfdeploy/master/deploy.png)](https://githubsfdeploy.herokuapp.com/?owner=Maxscores&repo=sfdc-rest-controller-framework&ref=master)

## Usage

To create a REST Controller for a specific resource, you'll need to create a class that inherits from **RESTController.cls** and uses the @RestResource annotaion. Below is an example of the basic class setup.
```java
@RestResource(UrlMapping='/accounts')
global class AccountsController extends RESTController {
    private static AccountsController controller = new AccountsController();
```
Additionally, you'll need to implement overrides and call them on the standard restful routes. Here's an example of the GET route:
```java
@RestResource(UrlMapping='/accounts')
global class AccountsController extends RESTController {
    private static AccountsController controller = new AccountsController();
    
    @HttpGet
    global static void getAccounts() {
        RestContext.response = controller.getRecords();
    }
    
    public override RestResponse getRecords() {
        // will need to implement the override method to return the response, something like:
        Account accountToReturn = [Select Id From Account];
        response.responseBody = new ResponseEnvelope(accountToReturn).getBlob();
        return response;
    }
}
```
When writing tests, you'll need to write an implementation of the resulting envelope class in that test method in order to parse the results from a JSON Blob into Apex. For the above example it would look something like this:
```java
@IsTest
public with sharing class RESTControllerTest {
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
