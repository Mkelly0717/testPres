with mkt as
(
select l1.loc, l1.yield, l2.u_mktsector, count(1)
from mak_damage_rate l1, loc l2
where l1.loc <> l2.loc                        and l1.loc='US1L'
  and l2.loc_type=3
  and l1.u_3digitzip=l2.u_3digitzip
  and l1.yield is not null
  and l1.yield > 0 and l1.yield < 1
group by l1.loc, l1.yield, l2.u_mktsector
order by l1.loc asc
),
loc_info as
(select loc, 
from loc)
select *
from mkt