db.employees.drop()

db.employees.insert({empno:7369 , ename : "SMITH", job : "CLERK", hiredate : "17-12-1980", sal : 800, deptno : 20 }) 
db.employees.insert({empno:7499 , ename : "ALLEN", job : "SALESMAN", hiredate : "20-02-1981", sal :1600, comm : 300, deptno : 30 })
db.employees.insert({empno:7521 , ename : "WARD", job : "SALESMAN", hiredate : "22-02-1981", sal : 1250, comm : 500, deptno : 30 })
db.employees.insert({empno:7566 , ename : "JONES", job : "MANAGER", hiredate : "02-04-1981", sal : 2975, deptno : 20 })
db.employees.insert({empno:7654 , ename : "MARTIN", job : "SALESMAN", hiredate : "28-09-1981", sal : 1250, comm : 1400, deptno : 30 })
db.employees.insert({empno:7698 , ename : "BLAKE", job : "MANAGER", hiredate : "01-05-1981", sal : 2850, deptno : 30 })
db.employees.insert({empno:7782 , ename : "CLARK", job : "MANAGER", hiredate : "09-06-1981", sal : 2450, deptno : 10 })
db.employees.insert({empno:7788 , ename : "SCOTT", job : "ANALYST", hiredate : "13-06-1987", sal : 3000, deptno : 20 })
db.employees.insert({empno:7839 , ename : "PRESIDENT", job : "CEO", hiredate : "17-11-1981", sal : 5000, deptno : 10 })
db.employees.insert({empno:7844 , ename : "TURNER", job : "SALESMAN", hiredate : "08-09-1981", sal : 1500, deptno : 30 }) 
db.employees.insert({empno:7876 , ename : "ADAMS", job : "CLERK", hiredate : "13-06-1987", sal : 1100, deptno : 20 })
db.employees.insert({empno:7900 , ename : "JAMES", job : "CLERK", hiredate : "03-12-1981", sal : 950, deptno : 30 })
db.employees.insert({empno:7902 , ename : "FORD", job : "ANALYST", hiredate : "03-12-1981", sal : 3000, deptno : 20 })
db.employees.insert({empno:7934 , ename : "CLERK", job : "CLERK", hiredate : "23-01-1982", sal : 1300, deptno : 10 })

db.employees.find()

--select * from employees;
db.employees.find()

--select ename from employees;
db.employees.find({},{_id:0, ename:1})

--select * from employees where deptno=20
db.employees.find({deptno:20})

--select * from employees where deptno!=20
db.employees.find({deptno:{$ne:20}})
db.employees.find({deptno:{$ne:20}}).count()

--select * from employees where deptno=20 and sal=1100
db.employees.find({$and:[{deptno:20}, {sal:1100}]})

--select * from employees where deptno=20 or deptno=10
db.employees.find({$or:[{deptno:10},{deptno:20}]})
db.employees.find({deptno:{$in:[10,20]}})

--select * from employees where sal>1100
db.employees.find({sal:{$gt:1100}})

--select * from employees sal<1100
db.employees.find({sal:{$lt:1100}})

/*
db.users.insert({name: 'paulo'})
db.users.insert({name: 'patric'})
db.users.insert({name: 'pedro'})
 
db.users.find({name: /a/})  //like '%a%'
out: paulo, patric
 
db.users.find({name: /^pa/}) //like 'pa%' 
out: paulo, patric
 
db.users.find({name: /ro$/}) //like '%ro'
out: pedro
*/

--select * from employees where ename like '%A%'
db.employees.find({ename:/A/})

--select * from employees where ename like 'A%'
db.employees.find({ename:/^A/})

--select * from employees where deptno=20 order by ename asc
db.employees.find({deptno:20}).sort({ename:1})

--select * from employees where deptno=20 order by ename desc
db.employees.find({deptno:20}).sort({ename:-1})

--select * from employees where deptno in(10,20)
db.employees.find({deptno:{$in:[10,20]}})

--update employees set sal=2000 where ename='ADAMS' or ename='FORD'
db.employees.update({ename:{$in:["ADAMS","FORD"]}},{$set:{sal:2000}},{multi:true})

/*
{
  _id: 1,
  sku: "abc123",
  quantity: 10,
  metrics: {
    orders: 2,
    ratings: 3.5
  }
}

db.products.update(
   { sku: "abc123" },
   { $inc: { quantity: -2, "metrics.orders": 1 } }
)

{
   "_id" : 1,
   "sku" : "abc123",
   "quantity" : 8,
   "metrics" : {
      "orders" : 3,
      "ratings" : 3.5
   }
}
*/

--update employees set sal=sal+100 where ename='ADAMS'
db.employees.update({ename:"ADAMS"},{$inc:{sal:1000}})

--부서가 10인 사람들의 sal을 200씩 증가
db.employees.update({deptno:10},{$inc:{sal:200}},{multi:true})

--이름이 ADAMS인 사람 제거
db.employees.remove({ename:"ADAMS"})


--select empno, ename from employees where sal<=1000
db.employees.find({sal:{$lte:1000}},{_id:0,empno:1,ename:1})

--select empno, ename, sal from employees where sal<=1000
db.employees.find({sal:{$lte:1000}}, {_id:0, empno:1, ename:1, sal:1})

--select empno, ename, sal from employees where sal>=1500 and sal<=3000
db.employees.find({sal:{$gte:1500, $lte:3000}},{_id:0, empno:1, ename:1, sal:1})

--select * from employees where deptno=10 or deptno=20
db.employees.find({deptno:{$in:[10,20]}})

--select empno, deptno from employees where deptno in(10,30)
db.employees.find({deptno:{$in:[10,30]}},{_id:0, empno:1, ename:1})

--select * from employeees where deptno=10 and sal>=1000
db.employees.find({$and:[{deptno:10},{sal:{$gte:1000}}]})