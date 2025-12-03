# learning_sql_test_1
I recently learnt the basics of sql and I am applying them to a 'hospital' dataset.  
It's still work in progress but soon i'll be done.  
## What i've done so far:  
      ** SQL ASSIGNMENT QUESTIONS (HEALTHCARE DATASET) **
      --1. Retrieve the list of all male patients who were born after 1990, including their patient ID, first
      --	name, last name, and date of birth.
      Used where to filter out the gender and date of birth
      
      --2. Produce a report showing the ten most recent appointments in the system, ordered from the
      --newest to the oldest.
      Ordered the appointments in descending order and limited them to 10
      
      --3. Generate a report that shows all appointments along with the full names of the patients and
      --doctors involved.
      Used a full join to get all the appointments along with the full names of the patients and doctors involved
      
      --4. Prepare a list that shows all patients together with any treatments they have received, ensuring
      --that patients without treatments also appear in the results.
      Used a left join on with patients table on the left when joining the patients table to the appointments table and the treatments table on patientId and        appointmentId respectively
      
      --5. Identify any treatments recorded in the system that do not have a matching appointment.
      Used a left outer join to join the treatments and appointments table on appointmentId then filtered where the appointmentID is Null
      
      --6. Create a summary that shows how many appointments each doctor has handled, ordered from
      --the highest to the lowest count.
      Joined the doctors table and the appointments table on doctorID 
      Introduced a count on the doctorID in the appointments table
      Grouped by name and doctorId and ordered by appointments count 
      
      --7. Produce a list of doctors who have handled more than twenty appointments, showing their
      --doctor ID, specialization, and total appointment count.
      Used a sub-query which:
       Joins the doctors and appointments table on doctorID 
      Counts the number of appointments each doctor has
      Groups the data by doctorID and specialization
      Selected all from the subquery and filtered by the number of appointments where appointments handled > 20
      
      --8. Retrieve the details of all patients who have had appointments with doctors whose
      --specialization is “Cardiology.”
      Joined the patients, appointments and doctors tables on patientID and doctorID respectively
      Filtered the data to read where doctor specialization is cardiology
      
      --9. Produce a list of patients who have at least one bill that remains unpaid.
      Created a subquery: 
      that joins patients, admissions and bills table on patientID and admissionID respectively
      Groups the data by patientID, name and admissionID
      Orders the data by the count of outstanding amount
      Selected all from the subquery and filtered by outstanding amount >0
      
      --10. Retrieve all bills whose total amount is higher than the average total amount for all bills in
      --the system.
      Created a subquery that gets the average total, groups the data by billID and TotalAmount and orders it by the total amount
      Selected all from the subquery and filtered the data to get bills whose total amount is higher than the average of the total amount
      
      --11. For each patient in the database, identify their most recent appointment and list it along with
     --the patient’s ID.
     Used a cte to get each patient’s appointment dates ranked from the latest
     Filtered from the cte to get the most recent appointment date for every patient ie the first rank from each patient
     
     --12. For every appointment in the system, assign a sequence number that ranks each patient’s
     --appointments from most recent to oldest.
     Used
            ROW_NUMBER() OVER (
            PARTITION BY 'PatientID' 
            ORDER BY "AppointmentDate" desc
        ) AS AppointmentSequenceRank
     To get the rank of appointment dates for each patient
     Then ordered by appointmentDate rank and patientId so that the list can start with the first patientID
     
     --13. Generate a report showing the number of appointments per day for October 2021, including a
     --running total across the month.
     Introduced a window function to assign a rank to each appointment based on the specific day 
     Filtered to get appointment details for the month of October 2021
     
     --14. Using a temporary query structure, calculate the average, minimum, and maximum total bill
     --amount, and then return these values in a single result set.
     Created a cte where i did all the aggregations 
     Selected all from the cte
     
     --15. Build a query that identifies all patients who currently have an outstanding balance, based on
     --information from admissions and billing records.
     Joined the admissions table to the bills table on admissionId
     Filtered to get patients whose outstandingAmount is not Null
     
     --16. Create a query that generates all dates from January 1 to January 15, 2021, and show how
     --many appointments occurred on each of those dates.
     Generated the 15 dates in a cte 
     Joined the cte to appointment table on appointmentDate
     COALESCE(COUNT(a."AppointmentID"), 0) AS total_appointments: This function converts any NULL values (which represent days with no appointments) into a 0, providing the desired count for every day in the range.
     
     --17. Add a new patient record to the Patients table, providing appropriate information for all
     --required fields.
     Used the insert into (col_names) values(val)
     
     --18. Modify the appointments table so that any appointment with a NULL status is updated to
     --show “Scheduled.”
     Updated the status column in the appointments table to read scheduled where the record was empty
     
     --19. Remove all prescription records that belong to appointments marked as “Cancelled.”
     Deleted from prescriptions table where appointmentID in appointments table had the status as ‘Cancelled’
     
     --20. Create a stored procedure that adds a new record to the Doctors table.
     --The procedure should accept the doctor’s ID, first name, last name, specialization, email, and
     --phone number as input parameters.
     --After creating the procedure, call it using a set of sample doctor details to insert a new doctor
     --into the database.
      Created a stored procedure that adds a new record to the Doctors table.
     After creating the procedure, called it using a set of sample doctor details to insert a new doctor
     into the database.
     
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
