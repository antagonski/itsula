import 'package:flutter/foundation.dart' show immutable;

@immutable
class Strings {
  static const allowLikesTitle = 'Allow likes';
  static const allowLikesDescription =
      'By allowing likes, you consent to users pressing the like button on your blog.';
  static const allowLikesStorageKey = 'allow_likes';
  static const allowCommentsTitle = 'Allow comments';
  static const allowCommentsDescription =
      'By allowing comments, you consent to users commenting on your blog.';
  static const allowCommentsStorageKey = 'allow_comments';

  static const comment = 'comment';
  static const loading = 'Loading...';
  static const person = 'person';
  static const people = 'people';
  static const likedThis = 'liked this';

  static const delete = 'Delete';
  static const areYouSureYouWantToDeleteThis =
      'Are you sure you want to delete this?';

  static const login = "Log in";
  static const regitser = "Register";
  static const logout = 'Log out';
  static const areYouSureThatYouWantToLogOut =
      'Are you sure that you want to Log Out?';
  static const cancel = 'cancel';
  static const space = " ";

  static const dontHaveAnAccount = "Don't have an account?";
  static const registerNow = "Register now";
  static const appName = 'ItsulA';
  static const welcomeMessage = "Welcome to ${Strings.appName}";

  static const youHaveNoBlogsYet = "You have not made a blog yet.";

  static const noBlogsAvailable = "Hmm, nobody has made a blog yet.";

  static const enterYourSearchTerm =
      'Enter your search term in order find the blog you want. The criteria can be anything from the description!';

  static const fb = "Facebook";
  static const facebookRegisterUrl = "https://www.facebook.com/signup";
  static const google = 'Google';
  static const googleRegisterUrl = 'https://accounts.google.com/signup';
  static const logIntoYourAccount =
      'Log into your account using one of the options below: ';
  static const comments = 'Comments';
  static const writeYourCommentHere = 'Write your comment here: ';
  static const checkTHISout = 'Check THIS out!';
  static const blogDetails = 'Blog Details';
  static const blog = 'blog';

  static const createNewBlog = 'Create New Blog';
  static const pleaseWriteYourMessageHere = 'Please write your message here';
  static const noCommentsYet = 'No comments have been written yet, sadge.';
  static const enterYourSearchTermHere = 'Enter your search term here: ';
  static const registerHere = 'Register by either creating an account on ';
  static const orRegisterWithEmailAndPasword =
      'Or register with an email and password.';
  static const newLine = "\n";
  static const forgotPaswordQuestionMark = "Forgot Password?";
  static const usernameHint = "Username";
  static const emailHint = "Email";
  static const passwordHint = "Password";
  static const orLogInWith = "Or log in with";

  static const anErrorHasOccurred = 'An error has occurred..';

  static const addANewBlog = 'Add a new blog';
  static const addJustABlog = 'Add just a blog, no image or video needed.';
  static const addABlogWithAnImage = 'Add a blog with an image.';
  static const addABlogWithAVideo = 'Add a blog with a video.';
  static const chooseHowYouWantToMakeANewBlog =
      'Choose how you want to make a new blog!';
  const Strings._();
}
