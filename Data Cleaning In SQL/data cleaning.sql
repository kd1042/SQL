
--standarzied the date format --

--alter table housing 
--add Sale_Date Date;

--update  housing 
--set sale_date = CONVERT(Date,SaleDate);

--alter table housing
--drop column SaleDate;


--populate property address data--

--select a.ParcelID,a.PropertyAddress,b.ParcelID,b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
--from housing a JOIN housing b
--on a.ParcelID = b.ParcelID
--and a.UniqueID <> b.UniqueID
--where a.PropertyAddress is null

--update a 
--set PropertyAddress =  ISNULL(a.PropertyAddress,b.PropertyAddress)
--from housing a JOIN housing b
--on a.ParcelID = b.ParcelID
--and a.UniqueID <> b.UniqueID
--where a.PropertyAddress is null


--breaking out address into  indiviual columns--

--select SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1) as Address
--, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))
--from housing;

--alter table housing
--add PropertySplitAddress Nvarchar(255);

--update housing
--set PropertySplitAddress =  SUBSTRING(PropertyAddress,1,CHARINDEX(',',PropertyAddress)-1);

--alter table housing
--add City Nvarchar(255)

--update housing
--set City =  SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress));

--select PropertySplitAddress, City from housing;


--split owner address--

--select 
--PARSENAME(REPLACE(OwnerAddress,',','.'),3),
--PARSENAME(REPLACE(OwnerAddress,',','.'),2),
--PARSENAME(REPLACE(OwnerAddress,',','.'),1)
--from housing;

--alter table housing 
--add Owner_Address Nvarchar(255),
--    Owner_City Nvarchar(255),
--	Owner_State Nvarchar(255);

--update housing
--set Owner_Address= PARSENAME(REPLACE(OwnerAddress,',','.'),3),
--    Owner_City =  PARSENAME(REPLACE(OwnerAddress,',','.'),2),
--	Owner_State = PARSENAME(REPLACE(OwnerAddress,',','.'),1);


--Change Y & N to Yes and No in "sold as Vacant" field

--update housing
--set SoldAsVacant =
--CASE when SoldAsVacant ='Y' THEN 'YES'
--     when SoldAsVacant ='N' THEN 'NO'
--	 else SoldAsVacant
--	 END

-- Remove Duplicates --
with ROWnumCTE as (
select * , ROW_NUMBER() Over
(Partition BY ParcelID,
              PropertyAddress,
			  SalePrice,
			  sale_date,
			  LegalReference
			  Order by UniqueId) as ROW_NUM
from housing
)
select * from ROWnumCTE
where ROW_NUM > 1;
--Delete from ROWnumCTE
--where ROW_NUM > 1



--delete unused column--
--alter table housing
--drop column OwnerAddress,TaxDistrict;


