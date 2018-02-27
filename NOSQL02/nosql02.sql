--1.부서별 인원수, 평균 급여, 가장 많은 급여, 가장 적은 급여를 추출하세요.
db.employees.aggregate([
     { $project: { --사용할 필드만 추출
         _id:0, 
         deptno:1, 
         ename:1, 
         sal:1
         }
     },
     { $group: { --deptno로 그룹별로 분류하고, 집계
         _id:"$deptno", 
         pcnt:{$sum:1}, 
         sal_info:{$addToSet:{ sal:"$sal", ename:"$ename" }}
         }
     },
     { $project: { --추출
         _id:1, 
         pcnt:1, 
         sal_info_max:{$max:"$sal_info"}, sal_info_min:{$min : "$sal_info"}
         }
     }
])
--뽑을 필드를 편집함.
--부서별로 문서를 그룹화함.(분류)
--그룹별로 pcnt필드(카운트) 가 나옴.
--각 그룹 안에 있는 sal,ename을 가진 가상 문서를 만듬.
--원본데이터 가공이 아닌, 원본데이터를 유지하고 싶으면 배열 사용.

--2.직업별 급여의 총 합과 평균을 추출하세요.
db.employees.aggregate([
     { $group: {
         _id:"$job", 
         total_sal:{$sum : "$sal"}, 
         avg_sal:{$avg : "$sal"}
         }
     }
])

--3.직업별 가장 많은 급여를 받는 사람의 이름을 추출하세요.
db.employees.aggregate([
     { $group: {
         _id:"$job", 
         sal_info:{$addToSet:{ sal:"$sal", ename:"$ename" }}
         }
     },
     { $project: {
         _id:0, 
         job:"$_id", 
         max_sal_info:{$max:"$sal_info"}
         }
     }
])
  
--4.급여를 가장 많이 받는 사람과 가장 적게 받는 사람의 차는 얼마인가      
db.employees.aggregate([
     { $group: {
         _id:0, 
         max_sal:{$max:"$sal"}, 
         min_sal:{$min:"$sal"}
         }
     },
     { $project: {
         _id:0, 
         sub_sal:{$subtract:["$max_sal", "$min_sal"]}
         }
     }
])