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

hash{name2}; # variable name as hash index

name + array[0];
name + array[0] + hash{name5};
