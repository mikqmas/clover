Clover Tools & Example
======================

[Example Rack(Ruby) OAuth WebApp](https://github.com/mikqmas/clover/blob/master/config.ru)
---
A simple webapp that returns auth token.
Run `rackup -p 3000` or your port #. Be sure to change appSecret and env. 

[deleteAllOpenOrdersForEmployee](https://github.com/mikqmas/clover/blob/master/deleteAllOpenOrdersForEmployee.rb)
---
In order to clock-out, all orders associated with an employee must be deleted. This ruby script deletes all open order without associated payment for an employee.
