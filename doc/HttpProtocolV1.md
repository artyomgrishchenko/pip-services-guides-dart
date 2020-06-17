# HTTP Protocol (version 1) <br/> Guides Microservice

Guides microservice implements a HTTP compatible API, that can be accessed on configured port.
All input and output data is serialized in JSON format. Errors are returned in [standard format]().

* [GuideV1 class](#class1)
* [DataPage<GuideV1> class](#class2)
* [POST /guides/get_guides](#operation1)
* [POST /guides/get_guide_by_id](#operation2)
* [POST /guides/create_guide](#operation3)
* [POST /guides/update_guide](#operation4)
* [POST /guides/delete_guide_id](#operation5)

## Data types

### <a name="class1"></a> GuideV1 class

Represents an guide

**Properties:**
- id: string - unique guide id
- name: string - guide name
- description: string - guide description
- product: string - product name
- copyrights: string - copyrights
- min_ver: number - minimum version
- max_ver: number - maximum version

### <a name="class2"></a> DataPage<GuideV1> class

Represents a paged result with subset of requested guides

**Properties:**
- data: [Guide] - array of retrieved Guide page
- count: int - total number of objects in retrieved resultset

## Operations

### <a name="operation1"></a> Method: 'POST', route '/guides/get_guides'

Retrieves a collection of guides according to specified criteria

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- filter: Object
  - tags: string - (optional) a comma-separated list of tags with topic names
  - status: string - (optional) guide editing status
  - author: string - (optional) author name in any language 
- paging: Object
  - skip: int - (optional) start of page (default: 0). Operation returns paged result
  - take: int - (optional) page length (max: 100). Operation returns paged result

**Response body:**
Array of Guide objects, DataPage<GuideV1> object is paging was requested or error

### <a name="operation2"></a> Method: 'POST', route '/guides/get_guide_by_id'

Retrieves a single guide specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- guide_id: string - unique guide id

**Response body:**
Guide object, null if object wasn't found or error 

### <a name="operation3"></a> Method: 'POST', route '/guides/create_guide'

Creates a new guide

**Request body:**
- correlation_id: string - (optional) unique id that identifies distributed transaction
- guide: GuideV1 - Guide object to be created. If object id is not defined it is assigned automatically.

**Response body:**
Created Guide object or error

### <a name="operation4"></a> Method: 'POST', route '/guides/update_guide'

Updates guide specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- guide: GuideV1 - Guide object with new values. Partial updates are supported

**Response body:**
Updated Guide object or error 
 
### <a name="operation5"></a> Method: 'POST', route '/guides/delete_guide_by_id'

Deletes guide specified by its unique id

**Request body:** 
- correlation_id: string - (optional) unique id that identifies distributed transaction
- guide_id: string - unique guide id

**Response body:**
Occured error or null for success
 
