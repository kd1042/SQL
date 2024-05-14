#we would be using SQL For Cleaning OUR DATA

#In This Project we go through the nashville housing data and work on the following issues
1. Converting the Date Column Into a Standard Date Format

2. We Have Some Missing Values Inside Property Address Field. which we fill using The Adjacent Columns (Using JOINS)
  ("EXample we have address for house no.40 on street 2 but not house no.39, so we can fill this field using address data of house no.40")


3.We Extract information about State,City by spliting  Property/Owner Address column into 3 columns (address,city,state) using string REPLACE FUNCTION.


4. Replace Y & N With 'YES' & 'No' in sold as column,  (using CASE statement)


5.We Find And Remove Duplicates
