# Aurora

To test integration with EDH using Karate and Mockoon.

## Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes. See deployment for notes on how to deploy the project on a live system.

### Prerequisites

What things you need to install the software and how to install them

```
1) Maven
2) Karate
3) Mockoon (optional, only required for unit testing
4) http://jsonpath.com/ - for testing and verifying json path
```

### Installing

Need to import the private key into the java keystore

```
keytool -importkeystore -srckeystore mypfxfile.pfx -srcstoretype pkcs12  -destkeystore aurora.store -deststoretype JKS
```

Say what the step will be

```
mvn verify
```

## Running the tests

Use Maven to run the test

```
mvn verify
```

### Break down into end to end tests

Refer to the last 3 for using dynamic data instead. The front few are just POCs (hardcoded)


## Built With

* [Karate](https://github.com/intuit/karate) - The web testing framework used
* [Maven](https://maven.apache.org/) - Dependency Management

## Contributing



## Versioning

We use [SemVer](http://semver.org/) for versioning. For the versions available, see the [tags on this repository](https://github.com/your/project/tags). 

## Authors

* **Jeffrey Ng** - *Initial work* - [PurpleBooth](https://github.com/stardust2810)

## License

None yet

## Acknowledgments

* Thanks to GovTech team (https://github.com/govTechSG/java-apex-api-security)

