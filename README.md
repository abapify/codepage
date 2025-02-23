# Codepage polyfill

It never happened and it happened again. Clean core requires a new class for code page and the old class is not allowed.

## Why?

`CL_ABAP_CODEPAGE` was a class SAP introduced long time ago and it was efficiently handling string <-> binary conversion for UTF-8 documents such as XML or JSON or whatever else.

We can [see](https://help.sap.com/docs/search?q=CL_ABAP_CODEPAGE+&locale=en-US&format=standard,html,pdf,others) that is still present in a new ABAP documentation snippets.
![image](https://github.com/user-attachments/assets/849cb89e-3aed-4271-a519-ece3db92bb45)

However it turned out to be one more example when "Clean Core" concept simply prevented us from using this class: 
`The use of Class CL_ABAP_CODEPAGE is not permitted`

![image](https://github.com/user-attachments/assets/11b0e390-ee8f-49c8-a4f2-36895300bc18)

So what should we use instead? Well there is another nice class which we can use: [CL_ABAP_CONV_CODEPAGE](https://help.sap.com/docs/btp/sap-business-technology-platform/string-processing?q=CL_ABAP_CONV_CODEPAGE)

Introducing one class in a new environment which is not present in the old environment prevents us from reusing the code. Polyfill approach allows us to use one class which will work in any system.

## ZCL_ABAP_CODEPAGE

Rountrip example from the unit test

```
data(test) = |This is a sample string|.
" String to xstring ( to codepage )
data(lv_binary) = zcl_abap_codepage=>to( test ).
" Xstring to string ( from codepage )
assert( zcl_abap_codepage=>from( lv_binary ) )->eq( test ).
```

## Test Dependencies
- [assert](https://github.com/abapify/assert)
- [throw](https://github.com/abapify/throw) (via assert)


