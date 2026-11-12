use [Banking Domain]

select * from Banking_data

-------->Key Performance Indicators (KPIs) Requirements:------->

--->Total Loan Applications:
select count(id) as TotalLoanApplication from Banking_data

select count(id) as MTD_TotalLoanApplication from Banking_data
where Month(issue_date)=12 and Year(issue_date)=2021

select count(id) as PMTD_TotalLoanApplication from Banking_data
where Month(issue_date)=11 and Year(issue_date)=2021

-->Formula for MOM > (MTD-PMTD)/(PMTD)  >>note example: currentmonthsale-previousmonthsale/previousmonthsale
-->(4314-4035)/4035 = 279/4035 = 0.069

--->Total Funded Amount:
select sum(loan_amount) as TotalFundedAmount from Banking_data

select sum(loan_amount) as MTD_TotalFundedAmount from Banking_data
where month(issue_date)=12 and year(issue_date)=2021

select sum(loan_amount) as PMTD_TotalFundedAmount from Banking_data
where month(issue_date)=11 and year(issue_date)=2021


--->Total Amount Received:
select sum(total_payment) as TotalAmountReceived from Banking_data

select sum(total_payment) as MTD_TotalAmountReceived from Banking_data
where Month(issue_date)=12 and Year(issue_date)=2021

select sum(total_payment) as PMTD_TotalAmountReceived from Banking_data
where Month(issue_date)=11 and Year(issue_date)=2021

--->Average Interest Rate:
select round(avg(int_rate),4)*100 as AverageInterestRate from Banking_data

select round(avg(int_rate),4)*100 as MTD_AverageInterestRate from Banking_data
where month(issue_date)=12 and year(issue_date)=2021

select round(avg(int_rate),4)*100 as PMTD_AverageInterestRate from Banking_data
where month(issue_date)=11 and year(issue_date)=2021

--->Average Debt-to-Income Ratio (DTI):
select round(avg(dti),4)*100 as Average_DTI from Banking_data

select round(avg(dti),4)*100 as MTD_Average_DTI from Banking_data
where month(issue_date)=12 and year(issue_date)=2021

select round(avg(dti),4)*100 as PMTD_Average_DTI from Banking_data
where month(issue_date)=11 and year(issue_date)=2021

----Good Loan KPIs------

--->Good Loan Application Percentage
select * from Banking_data


select (count(case when loan_status='Fully Paid' or loan_status='Current' then id end)*100/count(id)) as GoodLoanApp_percentage from Banking_data

--->Good Loan Applications
select count(id) Good_Loan_applications from Banking_data where loan_status='Fully Paid' or loan_status='Current'

--->Good Loan Funded Amount
select sum(loan_amount) as GoodLoan_FundedAmount from Banking_data where loan_status='Fully Paid' or loan_status='Current'

--->Good Loan Total Recieved Amount
select sum(total_payment) as GoodLoan_TotalRecievedAmount from Banking_data where loan_status='Fully Paid' or loan_status='Current'

----Bad Loan KPIs------

--->Bad Loan Application Percentage
select * from Banking_data


select (count(case when loan_status='Charged Off' then id end)*100/count(id)) as BadLoanApp_percentage from Banking_data

--->Bad Loan Applications
select count(id) Bad_Loan_applications from Banking_data where loan_status='Charged Off'

--->Bad Loan Funded Amount
select sum(loan_amount) as BadLoan_FundedAmount from Banking_data where loan_status='Charged Off'

--->Bad Loan Total Recieved Amount
select sum(total_payment) as BadLoan_TotalRecievedAmount from Banking_data where loan_status='Charged Off'

-----Loan Status Grid View-----
select Loan_status,count(id) as TotalLoan_Applications,sum(loan_amount) as TotalFunded_Amount,sum(total_payment) as TotalAmount_Recieved,avg(int_rate*100) as Average_InterestRate,avg(dti*100) as AverageDBT_Ratio
from Banking_data group by loan_status

select Loan_status,sum(loan_amount) as MTD_TotalFunded_Amount,sum(total_payment) as MTD_TotalAmount_Recieved 
from Banking_data where Month(issue_date)=12 group by loan_status


--------------KPI Dashboard Work Done Here------------
select * from Banking_data

---Monthly Trends by Issue Date
--Metrics:-'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
select Month(Issue_date) as Month_Number,DateName(Month,Issue_date) as Month_Name,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by Month(Issue_Date),DateName(Month,Issue_date) order by Month_Number

---Regional Analysis by State
--Metrics:-'Total Loan Applications,' 'Total Funded Amount,' and 'Total Amount Received'
select address_state ,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by address_state

---Loan Term Analysis
select term,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by term


---Employee Length Analysis 
select emp_length,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by emp_length order by emp_length

---Loan Purpose Breakdown
select purpose,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by purpose


---Home Ownership Analysis
select home_ownership,count(id) as Total_LoanApplications,sum(Loan_amount) as Total_FundedAmount,sum(total_payment) as Total_AmountRecieved from Banking_data group by home_ownership order by Count(id) desc



