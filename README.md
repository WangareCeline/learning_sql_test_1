# SQL Assignment Solutions (Healthcare Dataset)

## 1. Retrieve Male Patients Born After 1990
**Query Approach**: Used WHERE clause to filter by gender and date of birth

## 2. Ten Most Recent Appointments
**Query Approach**: Ordered appointments in descending order and limited to 10

## 3. Appointments with Patient and Doctor Names
**Query Approach**: Used FULL JOIN to get all appointments with patient and doctor full names

## 4. Patients with All Treatments (Including None)
**Query Approach**: Used LEFT JOIN with patients table on the left, joining to appointments and treatments tables on PatientID and AppointmentID respectively

## 5. Treatments Without Matching Appointments
**Query Approach**: Used LEFT OUTER JOIN between treatments and appointments tables on AppointmentID, then filtered WHERE AppointmentID is NULL

## 6. Doctor Appointment Summary
**Query Approach**:
- Joined doctors and appointments tables on DoctorID
- Introduced COUNT on DoctorID in appointments table
- Grouped by name and DoctorID
- Ordered by appointments count descending

## 7. Doctors with More Than 20 Appointments
**Query Approach**: Used subquery that:
1. Joins doctors and appointments tables on DoctorID
2. Counts appointments per doctor
3. Groups by DoctorID and specialization
4. Main query selects from subquery WHERE appointments > 20

## 8. Cardiology Patients
**Query Approach**:
- Joined patients, appointments, and doctors tables on PatientID and DoctorID
- Filtered WHERE doctor specialization = "Cardiology"

## 9. Patients with Unpaid Bills
**Query Approach**: Created subquery that:
1. Joins patients, admissions, and bills tables on PatientID and AdmissionID
2. Groups by PatientID, name, and AdmissionID
3. Main query selects from subquery WHERE outstanding amount > 0

## 10. Bills Above Average Total
**Query Approach**:
- Created subquery calculating average total amount
- Main query selects bills WHERE total amount > calculated average

## 11. Most Recent Appointment per Patient
**Query Approach**:
- Used CTE to rank each patient's appointments by date
- Filtered CTE to get first rank (most recent) for each patient

## 12. Appointment Sequence Numbers
**Query Approach**: Used window function:
```sql
ROW_NUMBER() OVER (
    PARTITION BY 'PatientID' 
    ORDER BY "AppointmentDate" DESC
) AS AppointmentSequenceRank
```
Ordered by appointment date rank and PatientID

## 13. Daily Appointments with Running Total (October 2021)
**Query Approach**:
- Used window function to rank appointments by day
- Filtered for October 2021 appointments
- Included running total calculation

## 14. Bill Amount Statistics
**Query Approach**: Created CTE with aggregations (AVG, MIN, MAX) and selected all from CTE

## 15. Patients with Outstanding Balances
**Query Approach**:
- Joined admissions and bills tables on AdmissionID
- Filtered WHERE outstandingAmount is NOT NULL

## 16. Appointments Count by Date (Jan 1-15, 2021)
**Query Approach**:
- Generated dates from Jan 1-15, 2021 in CTE
- Joined CTE to appointments table on AppointmentDate
- Used `COALESCE(COUNT(a."AppointmentID"), 0)` to handle days with no appointments

## 17. Add New Patient Record
**Query Approach**: Used `INSERT INTO (columns) VALUES (values)` syntax

## 18. Update NULL Appointment Status
**Query Approach**: Updated status column to "Scheduled" WHERE status was NULL

## 19. Remove Prescriptions for Cancelled Appointments
**Query Approach**: Deleted from prescriptions WHERE AppointmentID IN appointments with status "Cancelled"

## 20. Stored Procedure to Add New Doctor
**Implementation**: Created stored procedure that accepts doctor details and inserts into Doctors table

## 21. Stored Procedure for Appointment with Validation
**Implementation**: Created `new_appointment` procedure with:
- **Validation Logic**: Checks if patient and doctor exist
- **Error Handling**: Uses `RAISE EXCEPTION` to prevent insertion with specific error messages
- **Clear Feedback**: Different messages for each validation failure
- **Success Notification**: Uses `RAISE NOTICE` to confirm successful insertion
