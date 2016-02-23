<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;

use App\Post;
use App\Http\Requests;
use App\Http\Controllers\Controller;

class PostsController extends Controller
{
    public function getIndex() {
        file_get_contents("http://confoo-php.io/metrics.txt");
        $posts = Post::limit(10)->get();
        return view('posts.index', ['posts' => $posts]);
    }
}
