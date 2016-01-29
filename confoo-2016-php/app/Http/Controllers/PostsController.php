<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Post;
use App\Http\Requests;
use App\Http\Controllers\Controller;

class PostsController extends Controller
{
    public function getIndex() {
        \DB::enableQueryLog();
        return view('posts.index', ['posts' => Post::limit(30)->get()]);
    }
}
