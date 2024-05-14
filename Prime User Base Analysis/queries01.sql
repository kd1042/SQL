select * from ap;

--all members have their subscription end date set to year after purchase of the subscription
--even if they have subscribed to a monthly plan
--Fix Membership End Date if Membership is Monthly & Renwal  is set to Manual--
select "User ID",Name,"Subscription Plan","Membership Start Date",
DATEADD(MONTH,-11,"Membership End Date") as Renewal_Date,"Membership End Date","Renewal Status"
from ap
where "Subscription Plan" like '%Monthly%' and "Renewal Status" like '%Manual%';

update ap
set "Membership End Date" = DATEADD(MONTH,-11,"Membership End Date")
where "Subscription Plan" like '%Monthly%' and "Renewal Status" like '%Manual%';



--Remove Irrelevent Data Of Amazon Product Purchase History--
alter TABLE ap
DROP Column "Purchase History";


-- add age group tAb to divide the customer base and, get more insights on data on the basis of age-group . --

--alter TABLE ap
--add age_group varchar(100);

update ap
set age_group = 
CASE
   WHEN YEAR("Date Of Birth") <= 1970  THEN 'OLD'
   WHEN YEAR("Date Of BIRTH") <= 1995  THEN 'MILLENIALS'
   WHEN YEAR("Date Of BIRTH") <= 2010  THEN 'GEN Z'
   ELSE NULL
   end;


