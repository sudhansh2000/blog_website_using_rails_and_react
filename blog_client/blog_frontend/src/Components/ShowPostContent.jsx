import React, { useRef, useEffect } from 'react'
import EditorJS from '@editorjs/editorjs';
import Header from '@editorjs/header';
import List from '@editorjs/list';
// import Checklist from '@editorjs/checklist';
import Quote from '@editorjs/quote';
import Warning from '@editorjs/warning';
import Marker from '@editorjs/marker';
import CodeTool from '@editorjs/code';
import Delimiter from '@editorjs/delimiter';
import InlineCode from '@editorjs/inline-code';
import LinkTool from '@editorjs/link';
import Embed from '@editorjs/embed';
import Table from '@editorjs/table';
// import SimpleImage from '@editorjs/simple-image';
import ImageTool from '@editorjs/image';

import "./ShowPostContent.css";

const ShowPostContent = ({data}) => {
  
  const ejInstance = useRef(null);
  // const [content , setContent] = React.useState(null);

  useEffect(() => {
    if (!ejInstance.current) {
      ejInstance.current = new EditorJS({
        holder : 'content-area',
        autofocus: true,
        readOnly: true,
        data: data,
        tools: {
          header: Header,
          image: {
            class: ImageTool,
            config: {
              endpoints: {
                byFile: `${import.meta.env.VITE_API_BASE_URL}/uploads/image`, // for file upload
                byUrl: `${import.meta.env.VITE_API_BASE_URL}/uploads/image_by_url` // for URL upload (optional)
              }
            }
          },
          list: List,
          // checklist: Checklist,
          quote: Quote,
          warning: Warning,
          marker: Marker,
          code: CodeTool,
          delimiter: Delimiter,
          inlineCode: InlineCode,
          // linkTool: LinkTool,
          embed: Embed,
          table: Table
        },
        placeholder: 'Let`s write an awesome story!',
        /**
         * Internationalzation config
         */
      });

      ejInstance.current.isReady
        .then(() => {
          console.log("Editor.js is ready to work!");
        })
        .catch((reason) => {
          console.log(`Editor.js initialization failed: ${reason}`);
        });
    }
    // Clean up on unmount
    return () => {
      if (ejInstance.current && ejInstance.current.destroy) {
        ejInstance.current.destroy();
        ejInstance.current = null;
      }
    };
  }, [data]);

  // const savePost = async () => {
  //   ejInstance.current.save().then((outputData) => {
  //     setContent(outputData),
  //     console.log('Article data: ', outputData)
  //   }).catch((error) => {
  //     console.log('Saving failed: ', error)
  //   });
  // }
  return (
    <div>
      <div  id="content-area" key={`post-${data?.id}`} />
      {/* <button onClick={savePost}>save post</button> */}

      {/* <div>
        <h2>Saved Content:</h2>
        {
          content && <pre>{JSON.stringify(content, null, 2)}</pre>
        } 
        <pre>{EditorJS.render(content)}</pre>
      </div> */}

    </div>
  );
}

export default ShowPostContent
