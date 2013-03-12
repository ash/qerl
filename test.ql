my name;
my name2;

# one-line comment

my name4;

my name5 = name2;

name + name2;

{
    my name_block;
}

{
    my inner # no semicolon at the end of the block
}

{
    # empty block
}
{} # empty block

{
    my name6;
    { # inner block
        my name7;
    }

    {}
}

;;; # empty statements
{}; # also in this form
{;} # and more
{;};

my array[];
my hash{};

array[8];
array[-7];

hash{name2};  # variable name as hash index
hash<string>; # using strings (with no spaces etc.) as a hash key

name + array[0];
name + array[0] + hash{name5};

# my .global; # you can't define global variables
.env{name};
.args[1];

.evn<HOME> + .args[3];

(name2 + name3);
name + (name2 + .args[0] + (hash<string> + name6));

name2 name3;
name3 .env<HOME> .args[0];

name + name2 name3 + name5;

say(name);
say(first_name last_name);
say(first_name, last_name);
say(days(), months(), years(1990));

var1 + var2;
var1 - var2;
var1 * var2;
var1 / var2;

var1 + var2 * var3;
(var1 + var2) * var3;
var1 + (var2 * var3);

-var;
var1 + (-var2);

#value1 < value2;
value1 > value2;
value1 <= value2;
value1 >= value2;
value1 == value2;
value1 != value2;

a ≈ b ± delta;

!a;
!(a >= b);
