<h1>Posts</h1>

@foreach ($posts as $post)
    <p>{{ $post->title }}</p>
    <p>{{ $post->user->email}}</p>
    <p>{{ $post->tags->implode('name', ', ') }}</p>
    <hr>
@endforeach
