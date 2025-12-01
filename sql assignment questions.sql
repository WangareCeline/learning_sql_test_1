-- SQL ASSIGNMENT QUESTIONS (HEALTHCARE DATASET)
--1. Retrieve the list of all male patients who were born after 1990, including their patient ID, first
--	name, last name, and date of birth.
select "PatientID", "FirstName", "LastName", "DateOfBirth"
from patients p 
where "Gender" = 'M'
and "DateOfBirth" > '1990-12-31';

--2. Produce a report showing the ten most recent appointments in the system, ordered from the
--newest to the oldest.
select * from Appointments
ORDER by "AppointmentDate"  DESC
LIMIT 10;

-- changing AppointmentDate datatype
ALTER TABLE appointments 
ALTER COLUMN "AppointmentDate" TYPE DATE 
USING (
    CASE 
        WHEN "AppointmentDate" = '' THEN NULL 
        ELSE "AppointmentDate"::text::date 
    END
);

--3. Generate a report that shows all appointments along with the full names of the patients and
--doctors involved.
select "AppointmentID", a."PatientID", concat(p."FirstName",' ',p."LastName") as patient_name, 
	a."DoctorID", concat(d."FirstName", ' ', d."LastName") as doctor_name, "AppointmentDate", "Status", "NurseID"
from appointments a 
join patients p 
on a."PatientID" = p."PatientID" 
join doctors d 
on a."DoctorID" = d."DoctorID" ;

--4. Prepare a list that shows all patients together with any treatments they have received, ensuring
--that patients without treatments also appear in the results.
select a."AppointmentID" ,a."PatientID", concat("FirstName", "LastName") as patient_name, "TreatmentType"
from patients p 
left join appointments a 
on p."PatientID" = a."PatientID" 
join treatments t 
on a."AppointmentID" = t."AppointmentID";

--5. Identify any treatments recorded in the system that do not have a matching appointment.
select t."AppointmentID" ,"TreatmentID", "TreatmentType"
from treatments t 
left outer join appointments a
on t."AppointmentID" = a."AppointmentID"
where t."AppointmentID" is Null;

--6. Create a summary that shows how many appointments each doctor has handled, ordered from
--the highest to the lowest count.
select d."DoctorID", concat("FirstName", "LastName") as Doctor_name, count(a."DoctorID") as appointments_handled
from doctors d 
join appointments a 
on d."DoctorID" =a."DoctorID" 
group by d."DoctorID", doctor_name 
order by appointments_handled  desc;

--7. Produce a list of doctors who have handled more than twenty appointments, showing their
--doctor ID, specialization, and total appointment count.
select * 
from
	(select d."DoctorID", d."Specialization" , count(a."DoctorID") as total_appointment_count
	from doctors d 
	join appointments a 
	on d."DoctorID" =a."DoctorID" 
	group by d."DoctorID", d."Specialization" 
	order by total_appointment_count   desc)
where total_appointment_count >20;

--8. Retrieve the details of all patients who have had appointments with doctors whose
--specialization is “Cardiology.”
select p."PatientID" ,concat(p."FirstName", p."LastName") as patient_name ,p."Gender" ,p."DateOfBirth" ,p."Email" ,p."PhoneNumber" , a."DoctorID", d."Specialization"
from patients p 
join appointments a 
on p."PatientID" = a."PatientID" 
join doctors d 
on a."DoctorID" = d."DoctorID" 
where d."Specialization" = 'Cardiology'

--9. Produce a list of patients who have at least one bill that remains unpaid.
select *
from
	(select p."PatientID", concat(p."FirstName", p."LastName") as patient_name ,a."AdmissionID" , count(b."OutstandingAmount") as unpaid
	from patients p 
	join admissions a 
	on p."PatientID" =a."PatientID" 
	join bills b 
	on a."AdmissionID" =b."AdmissionID" 
	group by p."PatientID" ,patient_name ,a."AdmissionID" 
	order by unpaid desc )
where unpaid > 0;

--10. Retrieve all bills whose total amount is higher than the average total amount for all bills in
--the system.
select *
from
	(SELECT
    "BillID",
    "TotalAmount",
    AVG(SUM("TotalAmount")) OVER() AS average_overall_bill
	FROM
	    bills
	GROUP BY
	    "BillID", "TotalAmount"
	ORDER BY
	    average_overall_bill)
where "TotalAmount" > average_overall_bill;

--11. For each patient in the database, identify their most recent appointment and list it along with
--the patient’s ID.

--12. For every appointment in the system, assign a sequence number that ranks each patient’s
--appointments from most recent to oldest.

--13. Generate a report showing the number of appointments per day for October 2021, including a
--running total across the month.

--14. Using a temporary query structure, calculate the average, minimum, and maximum total bill
--amount, and then return these values in a single result set.

--15. Build a query that identifies all patients who currently have an outstanding balance, based on
--information from admissions and billing records.

--16. Create a query that generates all dates from January 1 to January 15, 2021, and show how
--many appointments occurred on each of those dates.

--17. Add a new patient record to the Patients table, providing appropriate information for all
--required fields.

--18. Modify the appointments table so that any appointment with a NULL status is updated to
--show “Scheduled.”

--19. Remove all prescription records that belong to appointments marked as “Cancelled.”

--20. Create a stored procedure that adds a new record to the Doctors table.
--The procedure should accept the doctor’s ID, first name, last name, specialization, email, and
--phone number as input parameters.
--After creating the procedure, call it using a set of sample doctor details to insert a new doctor
--into the database.

--21. Create a stored procedure that records a new appointment and automatically performs
--validation before inserting.
--The procedure should accept an appointment ID, patient ID, doctor ID, appointment date, status,
--and nurse ID.
--Inside the procedure, implement the following logic:
--* Verify that the patient exists in the Patients table.
--* Verify that the doctor exists in the Doctors table.

--* If either does not exist, prevent the insertion and return an error message.
--* If both exist, insert the appointment into the Appointments table.
--After creating the procedure, call it with sample data to demonstrate both a successful and a
--failed insertion attempt.
