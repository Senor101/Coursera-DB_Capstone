delimiter //
create procedure CheckBooking(in booking_date date, in table_number int)
begin
declare bookedTable int default 0;
	select count(bookedTable)
    into bookedTable from Bookings where Date = booking_date and TableNumber = table_number;
        if bookedTable > 0 then
      select concat( "Table ", table_number, " is already booked.") as "Booking status";
      else 
      select concat( "Table ", table_number, " is not booked.") as "Booking status";
    end if;

end //

call checkBooking("2022-10-12 00:00:00",3);


delimiter //

create procedure AddValidBooking(in booking_date date, in table_number int)
begin
	declare table_count int;
    start transaction;
    select count(*) into table_count from bookings where Date = booking_date and TableNumber = table_number;
    
    if table_count > 0 then 
    rollback;
    select concat("Table ", table_number, " is already booked - booking cancelled") as BookingStatus;
    else 
    insert into Bookings (Date , TableNumber) values (booking_date, table_number);
    commit ;
    select concat("Table ", table_number, " is booked successfully") as BookingStatus;
    end if;
end //

call AddValidBooking("2022-10-11 00:00:00", 2);


delimiter //
create procedure AddBooking(in b_id int, in c_id int, in t_no int, b_date date)
begin
	insert into Bookings(BookingsID, CustomerID, TableNumber, Date) values
    (b_id, c_id, t_no, b_date);
    select ("New booking added") as Confirmation;
end //
call AddBooking(5, 4, 12,"2022-10-29");


delimiter //
create procedure UpdateBooking(in b_id int, b_date date)
begin
	update Bookings set Date=b_date where BookingsID = b_id;
    select concat("Booking ",b_id, " updated") as Confirmation;
end //

call UpdateBooking(4,"2022-10-15");


delimiter //
create procedure CancelBooking(in b_id int)
   begin
 	 delete from Bookings where BookingsID = b_id;
     select concat("Booking ",b_id, " cancelled") as Confirmation;
 end //


call CancelBooking(4);



