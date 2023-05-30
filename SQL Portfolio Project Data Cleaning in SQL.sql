SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT SaleDate, CONVERT(Date,SaleDate) as SaleDate
FROM [Portfolio Project].[dbo].[NashvilleHousing]


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET SaleDate = CONVERT(Date,SaleDate)


Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD SaleDateConverted Date;


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET SaleDateConverted = CONVERT(Date,SaleDate)


SELECT SaleDateConverted, CONVERT(Date,SaleDate) as SaleDate
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT PropertyAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing]
Where PropertyAddress is null


SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]
Where PropertyAddress is null


SELECT PropertyAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing]
order by ParcelID


SELECT a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].[dbo].[NashvilleHousing] a
JOIN [Portfolio Project].[dbo].[NashvilleHousing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null


Update a
SET PropertyAddress =  ISNULL(a.PropertyAddress,b.PropertyAddress)
FROM [Portfolio Project].[dbo].[NashvilleHousing] a
JOIN [Portfolio Project].[dbo].[NashvilleHousing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID] <> b.[UniqueID]
WHERE a.PropertyAddress is null


SELECT PropertyAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)) as Address

FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) as Address

FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress)) as Address

FROM [Portfolio Project].[dbo].[NashvilleHousing]



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD PropertySplitAddress Nvarchar(255);


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress) -1) 



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD PropertySplitCity Nvarchar(255);


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET PropertySplitCity =  SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress) +1 , LEN(PropertyAddress))


SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT OwnerAddress
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT 
PARSENAME( REPLACE(OwnerAddress,',','.') , 3)
,PARSENAME( REPLACE(OwnerAddress,',','.') , 2)
,PARSENAME( REPLACE(OwnerAddress,',','.') , 1)
FROM [Portfolio Project].[dbo].[NashvilleHousing]



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD OwnerSplitAddress Nvarchar(255);


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET OwnerSplitAddress = PARSENAME( REPLACE(OwnerAddress,',','.') , 3)



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD OwnerSplitCity Nvarchar(255);


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET OwnerSplitCity =  PARSENAME( REPLACE(OwnerAddress,',','.') , 2)



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
ADD OwnerSplitState Nvarchar(255);


Update [Portfolio Project].[dbo].[NashvilleHousing]
SET OwnerSplitState = PARSENAME( REPLACE(OwnerAddress,',','.') , 1)


SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT 
PARSENAME( REPLACE(OwnerAddress,',','.') , 3)
,PARSENAME( REPLACE(OwnerAddress,',','.') , 2)
,PARSENAME( REPLACE(OwnerAddress,',','.') , 1)
FROM [Portfolio Project].[dbo].[NashvilleHousing]


SELECT Distinct(SoldAsVacant), Count(SoldAsVacant) as CountSoldAsVacant
FROM [Portfolio Project].[dbo].[NashvilleHousing]
Group By SoldAsVacant
order by 2

SELECT SoldAsVacant
,CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	  WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END
FROM [Portfolio Project].[dbo].[NashvilleHousing]


Update [NashvilleHousing]
SET SoldAsVacant = CASE WHEN SoldAsVacant = 'Y' THEN 'Yes'
	  WHEN SoldAsVacant = 'N' THEN 'No'
	  ELSE SoldAsVacant
	  END



WITH RowNUMCTE AS(
SELECT *, 
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

FROM [Portfolio Project].[dbo].[NashvilleHousing]
)
SELECT*
FROM RowNUMCTE
WHERE row_num > 1
Order by PropertyAddress



WITH RowNUMCTE AS(
SELECT *, 
	ROW_NUMBER() OVER(
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num

FROM [Portfolio Project].[dbo].[NashvilleHousing]
)
delete
FROM RowNUMCTE
WHERE row_num > 1



SELECT *
FROM [Portfolio Project].[dbo].[NashvilleHousing]


Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
Drop Column OwnerAddress, TaxDistrict, PropertyAddress



Alter Table [Portfolio Project].[dbo].[NashvilleHousing]
Drop Column SaleDate



