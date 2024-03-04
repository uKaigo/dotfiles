BEGIN {
  FS = "/";
  OFS = "/";

  # Anything less than 2 can break the program.
  if (fields <= 1) {
    ORS = "\n";
    print "Field number should be more than 1.";
    exit 1;
  }
}

{
  if (NF > 1) {
    # At "/", both $1 and $2 are empty, so print a "/" (from the OFS).
    if ($1 == "" && $2 == "") {
      print;
      exit;
    }

    # Adds a trailling "/" and joins all the printing.
    ORS = "/"

    start = NF - fields + 1

    # Allow "/" to be an additional segment.
    if ($(start - 1) == "") {
      print $1;
    }

    # Allows "~" to be an additional segment.
    if ($(start - 1) == "~") {
      print "~";
    }


    for (i = start; i <= NF; i++) {
      print $i;
    }
  } else {
    # Adds a trailling "/".
    ORS = "/"

    # Replace single "~" with the username, generally $USER.
    gsub("~", username);

    print $NF;
  }
}
