curl -X PUT 'http://localhost:9200/megacorp/employee/1' -d '{ "first_name": "John", "last_name": "Smith", "age": 25, "about": "I love to go rock climbing", "interests": [ "sports", "music" ]}'

curl -X PUT 'http://localhost:9200/megacorp/employee/2' -d '{ "first_name": "Jane", "last_name": "Smith", "age": 32, "about": "I love to collect rock albums", "interests": [ "music"]}'

curl -X PUT 'http://localhost:9200/megacorp/employee/3' -d '{ "first_name": "Douglas", "last_name": "Fir", "age": 35, "about": "I like to build cabinents", "interests": [ "foresty"]}'
