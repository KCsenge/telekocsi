namespace my.namespace;

entity member
{
    key id : UUID
        @Core.Computed;
    first_name : String(50) not null;
    last_name : String(50) not null;
    email : String(255) not null;
    contact_number : Integer not null;
    driving_licence_number : String(50);
    driving_licence_valid_from : Date;
    cars : Association to many member_car on cars.member = $self;
    member_preference : Association to member_preference on member_preference = $self;
}

entity car
{
    key id : UUID
        @Core.Computed;
    name : String(50) not null;
    make : String(50) not null;
    model : String(50) not null;
    make_year : Integer not null;
    comfort_level : Integer not null;
    members : Association to many member_car on members.car = $self;
}

entity member_car
{
    key id : UUID
        @Core.Computed;
    car: Association to car;
    member: Association to member;
    car_registration_number : String(50) not null;    
    car_color : String(50) not null;
}

entity member_preference
{
    key member_id: Association to member { id };
    is_smoking_allowed : Boolean not null;
    is_pet_allowed : Boolean not null;
    chitchat_preference: Association to chitchat_preference on chitchat_preference = $self; //elvileg id-ra mutat, ha nem adunk meg mezőt
    music_preference: Association to music_preference on music_preference = $self;
}

entity music_preference
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity chitchat_preference
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity ride
{
    key id : UUID
        @Core.Computed;
    member_car : Association to member_car on member_car = $self;
    created_on : Date not null;
    travel_start_time : Date not null;
    seats_offered : Integer not null;
    contribution_per_head : Integer not null;
    luggage_size : Association to luggage_size on luggage_size = $self;
    source_city : Association to city on source_city = $self;
    destination_city : Association to city on destination_city = $self;
}

entity luggage_size
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity city
{
    key id : UUID
        @Core.Computed;
    city_name : String(50) not null;
    state : String(50) not null;
    country : String(50) not null;
}

entity request
{
    key id : UUID
        @Core.Computed;
    requester :  Association to member on requester = $self; //member
    enroute_city: Association to enroute_city on enroute_city = $self;
    created_on : Date not null;
    request_status : Association to request_status on request_status = $self;
    ride : Association to ride on ride = $self;
}

entity request_status
{
    key id : UUID
        @Core.Computed;
    description : String(50) not null;
}

entity enroute_city
{
    key id : UUID
        @Core.Computed;
    ride : Association to ride on ride = $self;
    city : Association to city on city = $self;
    order_from_source : Integer not null;
    prorated_contribution : Integer not null;
}
