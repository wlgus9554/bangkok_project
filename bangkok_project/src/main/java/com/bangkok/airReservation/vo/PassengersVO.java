package com.bangkok.airReservation.vo;

import java.time.LocalDate;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class PassengersVO {
	
	private Long passengerNo;
    private Long reservationNo;
    private String first_name;
    private String last_name;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd") // 수정된 부분
    private LocalDate birth;
    
    private String nationality;
    private String passport_number;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd") // 수정된 부분
    private LocalDate passport_enddate;
    
    private String gender;
    private String passenger_type; // 'Adult', 'Child', 'Infant'

}
