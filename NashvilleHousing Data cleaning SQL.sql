select * from NashvilleHousing

--standaedize date format
select SaleDate, convert(date, SaleDate)
from NashvilleHousing

update NashvilleHousing
set SaleDate=convert(date,SaleDate)

Alter table NashvilleHousing
add SaleDateConverted date;

update NashvilleHousing
set SaleDateConverted=convert(date,SaleDate)

select SaleDateconverted, convert(date, SaleDate)
from NashvilleHousing

--populate property address
select PropertyAddress 
from NashvilleHousing
--where PropertyAddress is null

select a.ParcelID, a.propertyaddress, b.ParcelID, b.PropertyAddress, ISNULL(a.propertyaddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

update a
set PropertyAddress=ISNULL(a.propertyaddress, b.PropertyAddress)
from NashvilleHousing a
join NashvilleHousing b
on a.ParcelID=b.ParcelID
and a.[UniqueID ]<>b.[UniqueID ]
where a.PropertyAddress is null

--Breaking out whole address into individual columns(Address,city,state)
	--address
select 
SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) as Address
from NashvilleHousing

	--city
select 
SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1) as Address
,SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress)) as city
from NashvilleHousing


Alter table NashvilleHousing
add PropertySplitAddress Nvarchar(255);

update NashvilleHousing
set PropertySplitAddress =SUBSTRING(PropertyAddress,1, CHARINDEX(',',PropertyAddress)-1)


Alter table NashvilleHousing
add PropertySplittCity Nvarchar(255);

update NashvilleHousing
set PropertySplittCity = SUBSTRING(PropertyAddress,CHARINDEX(',',PropertyAddress)+1, len(PropertyAddress))


select *
from NashvilleHousing

select
PARSENAME(Replace(OwnerAddress,',' ,'.'),3),
PARSENAME(Replace(OwnerAddress,',' ,'.'),2),
PARSENAME(Replace(OwnerAddress,',' ,'.'),1)
from NashvilleHousing
--where ownername is not null

alter table NashvilleHousing
add OwnerSplittAddress nvarchar(250)

update NashvilleHousing
set OwnerSplittAddress= Parsename(replace(OwnerAddress, ',','.'),3)


alter table NashvilleHousing
add OwnerSplittcity nvarchar(250)

update NashvilleHousing
set OwnerSplittcity= Parsename(replace(OwnerAddress, ',','.'),2)


alter table NashvilleHousing
add OwnerSplitState nvarchar(250)

update NashvilleHousing
set OwnerSplitState= Parsename(replace(OwnerAddress, ',','.'),1)

select *
from NashvilleHousing

--change Y and N to Yes and No in 'Sold as Vacant' field
select distinct(SoldAsVacant), count(soldasvacant)
from NashvilleHousing
group by SoldAsVacant
order by 2

select SoldAsVacant,
case when SoldAsVacant= 'Y' then 'Yes'
	 when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end
from NashvilleHousing

update NashvilleHousing
set SoldAsVacant= case when SoldAsVacant= 'Y' then 'Yes'
	 when SoldAsVacant='N' then 'No'
	 else SoldAsVacant
	 end
from NashvilleHousing

--delete unsued columns

alter table NashvilleHousing
drop column PropertyAddress,OwnerAddress, TaxDistrict

select * from NashvilleHousing

alter table NashvilleHousing
drop column saledate
