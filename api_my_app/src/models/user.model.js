import mongoose from 'mongoose';

const { Schema } = mongoose;
const {
  ObjectId
} = mongoose.Schema;

const user = new Schema({
  // Bank account holder
  username: {
    type: String,
  },
  password: {
    type: String,
  },
  fname: {
    type: String,
  },
  lanme: {
    type: String,
  },
  updated_at: Date,
  created_at: Date
}, {
  timestamps: true,
  collection: 'user'
});

export default mongoose.model('user', user);

