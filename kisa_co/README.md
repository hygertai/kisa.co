# kisaco

A Flutter application.

## A short Description

kisa.co is a link-shortener application available for iOS and Android. The application takes user-provided URLs and transforms them into shortened URLs. Original URLs can be accessed via their shortened aliases. 

The mobile application makes HTTP requests to our API endpoints and will receive their generated URLs. Authenticated users can provide a custom expiration date, can modify the number of times the link can be accessed (i.e. view count limitation). For our authenticated users, there is also an option for URLs to be set as private. Private mode will ensure the generated URL will be relatively hard to predict and will have a longer URL length. 

The system also provides link analytics for the user to see their URLs view count and the location of these views in terms of IP address and country information. These analytics regarding shortened URLs could be seen by authenticated users on a separate information panel. 
