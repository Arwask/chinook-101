-- 1. Provide a query showing Customers (just their full names, customer ID and country) who are not in the US.

SELECT FirstName || ' ' || LastName as "Full Name", CustomerId, Country
FROM Customer where country not like 'USA';

-- 2. Provide a query only showing the Customers FROM Brazil.

SELECT * FROM Customer where country like 'Brazil';

-- 3. Provide a query showing the Invoices of customers who are FROM Brazil. The resultant table should show the customer's full name, Invoice ID, Date of the invoice and billing country.

SELECT c.FirstName || ' ' || c.LastName as "Full Name", i.InvoiceId, i.InvoiceDate, i.BillingCountry
FROM Customer c
JOIN Invoice i
ON c.CustomerId = i.CustomerId
WHERE c.Country LIKE 'Brazil';

-- 4.Provide a query showing only the Employees who are Sales Agents.

SELECT * FROM Employee
WHERE EmployeeId IN (SELECT DISTINCT SupportRepId FROM Customer);

-- 5. Provide a query showing a unique list of billing countries FROM the Invoice table.

SELECT DISTINCT BillingCountry FROM invoice;

-- 6. Provide a query that shows the invoices associated with each sales agent. The resultant table should include the Sales Agent's full name.

SELECT i.*, e.FirstName || ' ' || e.LastName as 'Full Name' FROM Invoice i, Customer c
JOIN Employee e 
WHERE c.CustomerId = i.CustomerId
AND e.EmployeeId = c.SupportRepId;

-- 7. Provide a query that shows the Invoice Total, Customer name, Country and Sale Agent name for all invoices and customers.

select i.total, c.FirstName || ' ' || c.LastName as CustomerName, c.Country, c.SupportRepId
from invoice i
join Customer c
where i.CustomerId = c.CustomerId;

-- 8. How many Invoices were there in 2009 and 2011? What are the respective total sales for each of those years?

select strftime('%Y', InvoiceDate) as year, count(*) total
from Invoice
where InvoiceDate like '2011%' 
or InvoiceDate like '2009%' 
group by strftime('%Y', InvoiceDate)

-- 9. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for Invoice ID 37.

select count(*) as 'total InvoiceLine', InvoiceId
from InvoiceLine 
where invoiceId = 37

-- 10. Looking at the InvoiceLine table, provide a query that COUNTs the number of line items for each Invoice. HINT: GROUP BY

select count(*) as 'total InvoiceLine', InvoiceId
from InvoiceLine 
group by invoiceId

-- 11. Provide a query that includes the track name with each invoice line item.

select t.Name, i.*
from Track t, InvoiceLine i
where i.TrackId = t.TrackId

-- 12. Provide a query that includes the purchased track name AND artist name with each invoice line item.

select t.Name as Track, i.*, r.Name Artist
from Track t, InvoiceLine i
on i.TrackId = t.TrackId
join Artist r, Album a
where r.ArtistId = a.ArtistId
and t.AlbumId = a.AlbumId

-- 13. Provide a query that shows the # of invoices per country. HINT: GROUP BY

select count(*), BillingCountry
from Invoice
group by BillingCountry

-- 14. Provide a query that shows the total number of tracks in each playlist. The Playlist name should be included on the resultant table.

select count(*) as total, p.Name
from PlaylistTrack pt, Playlist p
where pt.PlaylistId = p.PlaylistId
group by pt.PlaylistId

-- 15. Provide a query that shows all the Tracks, but displays no IDs. The resultant table should include the Album name, Media type and Genre.

select t.Name as Track, a.Title as Album, m.Name as Media, g.Name as Genre
from Track t, Album a, MediaType m, Genre g
where t.AlbumId = a.AlbumId
and t.GenreId = g.GenreId
and m.MediaTypeId = t.MediaTypeId

-- 16. Provide a query that shows all Invoices but includes the # of invoice line items.

select i.*, l.InvoiceLineId, count(l.InvoiceLineId) from
Invoice i, InvoiceLine l
where i.InvoiceId = l.InvoiceId
group by l.InvoiceId

-- 17. Provide a query that shows total sales made by each sales agent.

select count(*) as Sales, c.SupportRepId
from InvoiceLine l, Invoice i, Customer c
where l.InvoiceId = i.InvoiceId
and i.CustomerId = c.CustomerId
group by c.SupportRepId

-- 18. Which sales agent made the most in sales in 2009?

select max(sales), AgentId, Year
from(
select count(*) as Sales, c.SupportRepId as AgentId, strftime('%Y', InvoiceDate) as year
from InvoiceLine l, Invoice i, Customer c
where l.InvoiceId = i.InvoiceId
and i.CustomerId = c.CustomerId
and i.InvoiceDate like '2009%'
group by c.SupportRepId
);

-- 19. Which sales agent made the most in sales in 2010?

select max(sales), AgentId, Year
from(
select count(*) as Sales, c.SupportRepId as AgentId, strftime('%Y', InvoiceDate) as year
from InvoiceLine l, Invoice i, Customer c
where l.InvoiceId = i.InvoiceId
and i.CustomerId = c.CustomerId
and i.InvoiceDate like '2010%'
group by c.SupportRepId
);

-- 20. Which sales agent made the most in sales over all?

select max(sales), AgentId
from(
select count(*) as Sales, c.SupportRepId as AgentId
from InvoiceLine l, Invoice i, Customer c
where l.InvoiceId = i.InvoiceId
and i.CustomerId = c.CustomerId
group by c.SupportRepId
)

-- 21. Provide a query that shows the # of customers assigned to each sales agent.

select count(*), SupportRepId
from customer
group by SupportRepId

-- 22. Provide a query that shows the total sales per country. Which country's customers spent the most?

select count(*), i.BillingCountry
from InvoiceLine l, invoice i
where i.InvoiceId = l.InvoiceId
group by i.BillingCountry

-- 23. Provide a query that shows the most purchased track of 2013.

select max(Tracks), TrackName
from(
select count(*) as Tracks, t.Name TrackName
from Track t, InvoiceLine i, Invoice v
where i.TrackId = t.TrackId
and v.InvoiceId = i.InvoiceId
and v.InvoiceDate like '2013%'
group by t.TrackId
ORDER by t.TrackId Desc
)

-- 24. Provide a query that shows the top 5 most purchased tracks over all.

select count(*) as Tracks, t.Name TrackName
from Track t, InvoiceLine i, Invoice v
where i.TrackId = t.TrackId
and v.InvoiceId = i.InvoiceId
group by t.TrackId 
order by Tracks desc 
limit 5

-- 25. Provide a query that shows the top 3 best selling artists.

select count(*) as Tracks, t.Name TrackName, a.name as Artist
from Track t, InvoiceLine i, artist a, album l
where i.TrackId = t.TrackId
and a.ArtistId = l.Artistid
and l.AlbumId = t.albumid
group by a.ArtistId
order by Tracks desc
limit 3



-- Provide a query that shows the most purchased Media Type.


-- 27. Provide a query that shows the number of tracks purchased in all invoices that contain more than one genre.

