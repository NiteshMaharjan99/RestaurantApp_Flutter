const User = require("../model/User")


const getUserByID = async (req, res, next) => {
    const id = req.user.id;
    let user;
    try {
      user = await User.findById(id)
    } catch (err) {
      console.log(err);
    }
    if (!user) {
      return res.status(404).json({
        success: false,
        message: "No User Found",
      });
    }
    // console.log(user);
    return res.status(200).json({
      success: true,
      message: "User Details",
      data: user,
    });
  };

  module.exports = {
    getUserByID
  }